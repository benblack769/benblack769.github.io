---
title: "Pipeline-Lib"
slug: pipeline-lib
under_construction: false
excerpt: "A streaming pipeline accelerator micro-framework for Python."
website: ""
publication: ""
code: "https://github.com/Techcyte/pipeline-lib"
comments: false
share: false
post_date: "2024"
priority: 1
img: /images/pipeline-processing/pipeline_diagram.svg
---


What Python's `multiprocessing.Pool` provides for data parallelism, this micro-framework attempts to provide for stream parallelism: high quality pythonic tooling for supporting simple, fast, pure-python parallel stream processing, with robust, pythonic error handling.

### References

* [Source code and usage documentation (github)](https://github.com/Techcyte/pipeline-lib)
* [Longer writeup about inspiration and integration into a real production system](https://benblack769.github.io/posts/rants/pipeline-processing/)

#### Strengths:

* Extremely robust error handling (error handling as a first-class citizen, a central part of API design rather than an afterthought).
* High throughput message handling. >10,000+ messages per second, >1GB/s of memory transfer in [benchmarks](https://github.com/Techcyte/pipeline-lib#benchmarks)
* No-comprimises API design from years of experience working with ML and scientific inference systems. Deployed in real use-cases in production with 99%+ GPU utilization.
* Pure-python: simple to install/deploy, no binary dependencies
* Runtime type checking for strict enforcment of up-front design

#### Weaknesses:

* Porting cost: Existing code needs lots of adaptation to get it to fit the framework's execution model
* Pure-python: Not competitive with comparable C++ frameworks in terms of message or data throughput. 



## Design

### Compute model

A Pipeline has three parts:

1. A *source* generator, outputting a stream of work items
2. *Processor* generators, consuming a linear stream of inputs and producing stream of outputs. These streams do not have to be one-to-one. If the inputs and outputs can be handled independently (user responsible for verifying this), then these processors can be multiplexed across parallel threads.
3. A *sink*: a function that consumes an iterator, returns None

The runtime execution model has a few key concepts:

1. Max Packets in Flight: Max number of total packets being constructed or being consumed. A "packet" is assumed to be under construction whenever a producer or a consumer worker is running. So `packets_in_flight=1` means that the work on the data is completed fully synchronously. If the number of packets is greater than the number of workers, they are stored FIFO queue buffer. See [synchronous processing section below](#synchronous-processing) for more details.
1. Workers: A worker is an independent thread of execution working in an instance of a generator. More than one worker can potentially lead to greater throughput, depending on the implementation.
1. Buffer size (*multiprocessing only*): If `max_message_size` is set, then uses a shared memory scheme to pass data between producer and consumer very efficiently (see benchmark results below). **Warning**: If the actual pickled size of the data exceeds the specified size, then an error is raised, and there is no performance cost to the buffer being too large, so having large buffers is encouraged. If the `max_message_size` is not set, then it uses a pipe to communicate arbitrary amounts of data.

#### Synchronous processing

A unique feature of the pipeline lib is *synchronous processing*, an odd feature in a parallel pipeline, but one designed to minimize total processing latency when needed.  This is particularly useful for distributed data processing systems where each worker is consuming from a shared pool of work, and should not reserve too much work for itself that it cannot process quickly.

This tradeoff latency vs bandwidth of pipeline message processing is controlled by a single parameter `packets_in_flight`. From a consumer's perspective, the `packets_in_flight` is an ordinary queue buffer size. If there are available packets that a producer has placed in the buffer, then the consumer can consume them. For example, see the following diagram, which is limited by producer capacity.

![producer bound system](docs/producer_bound.png)

From the producer side, however, it is quite different than a queue, in that the system will not yield control back to the worker until there are empty slots available to start producing. See diagram below of system which is limited by consumer capacity. The producers are blocking because all 7 slots are filled, with 5 messages stored in the buffer, waiting to be consumed, and 2 of which are being processed by consumers.

![consumer bound system](docs/consumer_bound.png)

Note the effect of having a series of tasks with `packets_in_flight=1` means that multiple steps execute sequentially. For example, in the below diagram, task 1 is being blocked on the single packet in queue 1 being released, as that is being held by task 2. However, task 2 is in turn being blocked by task 3. Note that even though task 2 is blocked, it still reserving the space on queue 1.

![sequential execution chain](docs/sequential_chain.png)


The system enforces this by not yielding control back to the producer until there is a slot available

```python
def generator():
    ...
    # will block until there is space available
    # to produce the next message
    yield message
    ...
```

### Runtime error handling behavior

The following rules for handling errors are tested.

1. If any task exits with *either* an exception *or* a non-zero process exit code, then no more packets will be passed, the whole pipeline will be asked to finish working on its packet for at least 15 seconds, and then be forcefully terminated. The first exception raised, or the first non-zero exit code encountered, will be raised as an exception from the `execute` call.


## Example

(see [https://github.com/Techcyte/pipeline-lib/blob/main/examples/image_batch_example.py](https://github.com/Techcyte/pipeline-lib/blob/main/examples/image_batch_example.py)) for the complete example. You can run this example by installing the dev dependencies with `pip install ".[dev]"` then running `python -m examples.image_batch_example`.


```python
#...imports
from pipeline_lib import PipelineTask, execute

"""
Each of these functions are valid pipeline steps.

Note that the typings are checked at runtime for
consistency with downstream steps. So you will
get an error if it is untyped or incorrectly typed.
"""


def run_model(
    img_data: Iterable[np.ndarray], model_source: str, model_name: str
) -> Iterable[np.ndarray]:
    model = torch.hub.load(model_source, model_name)
    for img in img_data:
        results = model(img)
        yield results


def load_images(imgs: List[str]) -> Iterable[np.ndarray]:
    """
    Load images in the image list into memory and yields them.

    Note that as the first step in the pipeline, it does not need
    to accept an iterable, it can pull from a distributed queue,
    or a database, or anything else.

    Once parallelized in the pipeline-lib framework,
    these images will be loaded in parallel with the model inference
    """
    for img in imgs:
        with urllib.request.urlopen(img) as response:
            img_pil = Image.open(response, formats=["JPEG"])
            img_numpy = np.array(img_pil)
            yield img_numpy


def run_model(
    img_data: Iterable[np.ndarray], model_source: str, model_name: str
) -> Iterable[pandas.DataFrame]:
    """
    Run a model on every input from the img_data generator
    """
    model = torch.hub.load(model_source, model_name)
    for img in img_data:
        results = model(img).pandas().xyxy
        yield results


def remap_results(
    model_results: Iterable[pandas.DataFrame], classmap: Dict[int, str]
) -> Iterable[Tuple[str, float]]:
    """
    Post-processes neural network results. This example does something silly and
    chooses the highest confidence single box in an object prediction task from the scene
    """
    for result in model_results:
        df = result[0]
        result_class_idx = np.argmax(df["confidence"])
        best_row = df.loc[result_class_idx]
        result_confidence = best_row["confidence"].item()
        result_class_id = best_row["class"].item()
        result_class = classmap[result_class_id]
        yield (result_class, result_confidence)


def aggregate_results(classes: Iterable[Tuple[str, float]]) -> None:
    """
    Post-processing and reporting are combined in this step for simplicity.
    There could be multiple post-processing steps if you wish.
    """
    results = list(classes)
    class_stats = Counter(name for name, conf in results)
    print(class_stats)


def main():
    imgs = [
        "https://ultralytics.com/images/zidane.jpg",
        "https://ultralytics.com/images/zidane.jpg",
        "https://ultralytics.com/images/zidane.jpg",
    ]
    # The system details of the pipeline (number of processes, max buffer size, etc)
    # are defined in a list of simple PipelineTask objects, then executed.

    # Note that in theory, this list of PipelineTask can be built dynamically,
    # allowing for various sorts of encapsulation to be built around this library.
    execute(
        tasks=[
            PipelineTask(
                load_images,
                constants={
                    "imgs": imgs,
                },
                packets_in_flight=2,
            ),
            PipelineTask(
                run_model,
                constants={
                    "model_name": "yolov5s",  # or yolov5n - yolov5x6, custom
                    "model_source": "ultralytics/yolov5",
                },
                packets_in_flight=4,
            ),
            PipelineTask(
                remap_results,
                constants={
                    "classmap": {
                        0: "cat",
                        1: "dog",
                    }
                },
            ),
            PipelineTask(aggregate_results),
        ]
    )
```
