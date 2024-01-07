---
title: "High Performance Pipeline Processing in Python"
slug: pipeline-processing
under_construction: true
excerpt: "Building a new high performance pipeline processing tool in python, using low-level multi-processing features and advanced python pickling protocols."
comments: false
share: false
img: /images/pipeline-processing/pipeline_diagram.svg
post_date: "2024"
---

Every software development advice usually starts with: *"Don't reinvent the wheel"*. I like this advice, but it isn't perfect. Occasionally, appropriate high level tooling just doesn't exist, or is simply overly complex, and requires reinvention. I was quite pleased with how this pipeline processing project turned out, and I hope it can be used as a model for developing a clean, foolproof-by-default, feature-light-but-flexible, high-performance interface using stable low level tooling.

### When should we reinvent the wheel?

This phrase *"Don't reinvent the wheel"* is typically used to encourage people to research existing technologies and existing high level tooling. The end goal is to get engineering teams focused on business problems, which have innumerable nuance, over technical problems, which usually have been modeled abstractly and solved pretty darn well in some surprisingly general situations.

I try to follow this advice as closely as possible:  to use high level tooling, to keep code simple and free of low level complications, and to optimize performance within the limitations of common usage patterns with those high level tools. However, I occasionally see tremendous value in deviating and building out new, abstract high level systems with low level tooling. However, I only do so when:

1. There doesn't seem to be any solid solution to the problem in the open source world. So some complex creativity is needed anyways, either in workarounds or compromises.
1. This problem can be modeled with some (perhaps novel) high level abstract framework, and separated into a library in a distinct codebase with its distinct set of tests and release process. So the low level complexity can be contained to one codebase, and other codebases will not need to know the low level implementations details.
1. To avoid leaky abstractions, this abstract problem should be robust to a variety of errors, and should be solved in full generality with high efficiency and low absolute resource utilization.  Again, the importance of building this high level interface is to get engineering teams discussing and researching business problems, rather than nuances in implementation, so it has to work well out of the box. 

### Problem inspiration

The inspiration for this problem comes from a ML inference pipeline that I worked on in 2021. This inference system was a distributed queue-worker based system. Each worker was also optimized to maximize efficiency and reduce costs. However, during this optimization process, the implementation was optimized in a half-hazard manner, using knots of deeply nested and overlapping mess of multi-processing, multi-threading, pipes, queues, events, error handling, etc. After the original developer left the team, the code was viewed as incomprehensible and unmaintainable.

When dealing with incomprehensible code, it can be good to try to roughly sketch out each conceptual component, i.e. de-construct the code, and try to re-conceptualize of the problem the code is trying to solve. First, I modeled the code as a pipeline, as any pipeline worker will be mostly stateless, and the processing took many steps. Second, I dived into the code, and tried my best to manually translate the crazy mess of queues and multiprocessing into this rough processing diagram:

![Classifier-diagram](/images/pipeline-processing/images/image12.png)

I sat on this diagram for a few weeks while I focused on other tasks, and when I turned back to this problem, this diagram gave me the mental structure and confidence I needed to really invest in building out this high level pipeline processing framework.

### The high-level pipeline-processing API

After a few weeks, I converged on this idea of creating a high-level pipeline processing framework that could solve this processing task, and similar tasks, without any manually managed parallelism or synchronization constructs.

When designing the high level API, I thought of the most familiar way of achieving pipelining in unix: the command pipe.

```
$ cat sample.a | grep -v dog | sort -r
```

I remembered this idea from my previous employer that python generators are the most pythonic equivalent of unix pipes. Each "command" is turned into a generator which accepts an iterator, and returns an iterator:

```python
img_iter = load_images(imgs)
model_results = run_model(img_iter, model_name="yolov5s", model_source="ultralytics/yolov5")
post_processed_results = remap_results(model_results, classmap= {0: "cat", 1: "dog"})
final_result = aggregate_results(post_processed_results)
print(final_result)
```

<details>
  <summary>Click to show full working example</summary>

```python
import urllib
from collections import Counter
from typing import Iterable, List

import numpy as np
import pandas
import torch
from PIL import Image


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


def load_images(imgs: List[str]) -> Iterable[np.ndarray]:
    """
    Load images in the image list into memory and yields them. 
    Once parallelized in the pipeline-lib framework,
    these images will be loaded in parallel with the model inference
    """
    for img in imgs:
        with urllib.request.urlopen(img) as response:
            img_pil = Image.open(response, formats=["JPEG"])
            img_numpy = np.array(img_pil)
            yield img_numpy


def aggregate_results(classes: Iterable[pandas.DataFrame]) -> None:
    results = list(classes)
    class_stats = Counter(name for result in results for res in result for name in res.loc[:,'name'])
    print(class_stats)

def main():
    imgs = [
        'https://ultralytics.com/images/zidane.jpg',
        'https://ultralytics.com/images/zidane.jpg',
        'https://ultralytics.com/images/zidane.jpg'
    ]
    img_iter = load_images(imgs)
    model_results = run_model(img_iter, model_name="yolov5s", model_source="ultralytics/yolov5")
    final_result = aggregate_results(model_results)
    print(final_result)

main()
```

</details>

Unfortunately, unlike unix pipes, python iterators are evaluated totally sequentially. Fortunately, this means we will have way more control over backpressure and parallelism when configuring the pipeline.

To maximize the amount of control over message passing and error propagation (which is surprisingly hard to do right in a multiprocessed system), I went ahead and wrapped the whole pipeline in a big execute command, which allows the system resources to be configured. Like so:

```python
imgs = [
    'https://ultralytics.com/images/zidane.jpg',
    'https://ultralytics.com/images/zidane.jpg',
    'https://ultralytics.com/images/zidane.jpg'
]
execute(tasks=[
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
            "model_name": 'yolov5s', # or yolov5n - yolov5x6, custom
            "model_source": 'ultralytics/yolov5',
        },
        packets_in_flight=4,
        num_workers=2,
    ),
    PipelineTask(
        remap_results,
        constants={
            "classmap": {
                0: "cat",
                1: "dog",
            }
        }
    ),
    PipelineTask(
        aggregate_results
    )
])
```


### Justifying the framework

Real world code is always developed in the context of a team of talented individuals with differing ideas of what considerations are most important when developing code.

I ended up receiving pushback about the creation of a high level framework from the CTO, and also pushback about the pipelined parallelism model from my direct supervisor.

To move forwards, I had to craft a solid argument explaining:

1. Why pipelining was the best way to parallelize this system, given the alternatives?
2. Why a new framework was needed to be successful in all cases?
3. Why this framework wouldn't degrade into something unmaintainable and awful in the long term?

I abstracted this detailed system into its higher level components: 6 main steps: Pulling, pre-processing, GPU inference, post-processing, and Upload. Pre-processing and post-processing were CPU intensive, pulling, download, and upload were high latency, and GPU inference was clearly GPU heavy. 

The constraints were:

1. GPU memory was already pushed to the limits, so we could only run one process on the GPU at a time.
2. Some jobs are very large, taking 30 minutes to process a single job, with high resource utilization. So we can't pull batches of jobs without care, or else it might take hours to process all of them even if they are parallelized.
3. Some jobs are very small, executing in 0.15s on the GPU. So absolute overhead is a concern. However, a few seconds of latency isn't a problem, as it is a queue worker where the user doesn't see the response times. 

Given these constraints, we can examine ways to parallelize these steps. First, you can try to simply have multiple workers on each instance:

![independent-workers](/images/pipeline-processing/images/independent-workers.png)

While independent workers can get high resource utilization on an instance, it was a non-starter since we knew that GPU memory was already pretty much maxed out even with a single process.

If you simply put the GPU into its own process to conserve GPU memory, you get a process diagram that looks like this:

![gpu-coordinated-workers](/images/pipeline-processing/images/gpu-shared.png)

Unfortunately, this diagram starts to look unfortunately similar to the original codebase with its mess of processes and queues and custom error handling code.

So a fully pipelined process starts to look quite attractive by comparison:

![single-pipeline](/images/pipeline-processing/images/single-pipeline.png)

The idea being that different processing jobs pulled from the distributed queue will be processed in parallel in different pipeline steps.

This parallelism model uses minimal memory, and also is quite simple, implementing all parallelism with a single construct.

Unfortunately, python doesn't have great three new challenges:

1. 
2. **Robust Error Propagation:** When one pipeline step crashes, the other pipeline steps need to be shut down and the whole process needs to exit nicely with an informative error message. 
3. **Error handling:** One job encountering a recoverable, job-specific error, such as an API failure during upload or download, should not interrupt the other commands running in parallel. This was solved outside the high level framework using a code pattern described in the appendix [TODO: MAKE THIS PAGE AND LINK TO IT].

Note that to get good parallelization, different steps of the pipeline need to be handling different commands at the same time. However, jobs are of widely varying 

### Pipeline abstraction

A common parallelism pattern for efficient, latency sensitive, memory sensitive, variable sized work like this is a simple, linear pipeline processing with configurable backpressure. 


An easily composable, extensible pipeline processing code pattern in native, sequential python is by composing generators. An example of what this looks like is shown below. In the below example, there are 

```python
import urllib
from collections import Counter
from typing import Dict, Iterable, List, Tuple

import numpy as np
import torch
from PIL import Image


def run_model(
    img_data: Iterable[np.ndarray], model_source: str, model_name: str
) -> Iterable[np.ndarray]:
    model = torch.hub.load(model_source, model_name)
    for img in img_data:
        results = model(img)
        yield results


def load_images(imgs: List[str]) -> Iterable[np.ndarray]:
    for img in imgs:
        with urllib.request.urlopen(img) as response:
            img_pil = Image.open(response, formats=["JPEG"])
            img_numpy = np.array(img_pil)
            yield img_numpy


def remap_results(
    model_results: Iterable[np.ndarray], classmap: Dict[int, str]
) -> Iterable[Tuple[str, float]]:
    for result in model_results:
        result_pd = result.pandas().xyxy[0][:,'class']]
        print(result_pd)
        best_row_idx = np.argmax(result_pd.loc[:,'confidence'])
        best_conf = result_pd.loc[best_row_idx,'class']
        result_model_idx = result_pd.loc[best_row_idx,'class']
        best_class = classmap[result_model_idx % (1+max(classmap.keys()))]
        yield (best_class, best_conf)


def aggregate_results(classes: Iterable[Tuple[str, float]]) -> None:
    results = list(classes)
    class_stats = Counter(clas for clas, conf in results)
    print(class_stats)

def main():
    imgs = [
        'https://ultralytics.com/images/zidane.jpg',
        'https://ultralytics.com/images/zidane.jpg',
        'https://ultralytics.com/images/zidane.jpg'
    ]
    img_iter = load_images(imgs)
    model_results = run_model(img_iter, model_name="yolov5s", model_source="ultralytics/yolov5")
    post_processed_results = remap_results(model_results, classmap= {0: "cat", 1: "dog"})
    final_result = aggregate_results(post_processed_results)
    print(final_result)

main()
```


This method has every perk of a pipelining system except parallelism: It has has perfect backpressure, never loading more than one image at a time, and extremely low overhead, as it is natively supported by the language runtime.

So I decided to use this generator composition method as the programming model for the parallelized pipelining system. The only difference would be a framework would intake the relevant generators and compose them, rather than simply composing them in python as above. 






Can we design a good parallelism strategy from the top down if we were to write the classifier from scratch?


As part of the training v2 effort, we had an opportunity to try our hand at this while creating the training v2 classification service. While this is pretty much ready for training purposes, it is still in a prototype phase for production, and would benefit from review of those more familiar with production classification challenges. The current implementation is https://gitlab.com/techcyte/training/classifiers/efficientdet-classifier


The first step to designing a parallelism strategy is examining the key data dependencies between all the tasks and all the units of work:




Threading only (not recommended)


The easiest way to parallelize any problem is with threading, to put each large chunk of work, (in this case, the command), onto a thread, where it will run sequentially to completion. However, the problems with this strategy are too great, and I cannot recommend it.




Benefits

OS schedules all parallelism; to programmer, all code looks sequential
Problems:

GPU memory strain
Latency/throughput tradeoff: More workers mean slower individual processing
Processing a single region happens sequentially—slow latency for processing an individual region


Threaded + Separate GPU worker (not recommended)


To deal with limited GPU memory, and to allow for concurrency between pre-processing and GPU classification on a single sample, we could have a separate GPU worker which is shared among the command threads. Unfortunately, this leads to difficult tuning of the number of workers, and complex error handling, and I believe there is a better strategy.




Benefits:

GPU memory conserved
Pre-processing + GPU classification can happen in parallel even on a single region
Problems:

Latency/throughput tradeoff: More workers mean slower individual processing
More complicated error handling
How should the GPU process detect if there are errors in a worker it is sending a message to?
How should worker processes detect if there is an error in the GPU process?


Pipeline only (recommended)


Instead of dividing work between commands, we could divide the work only between the execution steps, into a classical streamlined data pipeline. This strategy has a couple of implementation complexities, however it maximizes efficient resource utilization, and minimizes vertical specific tuning, so it is the proposed basic approach.




Benefits:

Simple, popular design means framework can handle multiprocessing for us—less need for custom multiprocessing logic
Minimal memory consumption in GPU + CPU
Backpressure principle (blocking upstream processes until downstream process buffers have enough room) manages throughput/latency tradeoff for us—- allows for a single configuration can efficiently process large samples and small samples
Pure functional workers, easy to unit test
Problems:

Difficult to maintain consistent command status (logging, time to completion, metrics, alerts, early stopping, etc)

Fine grained pipeline strategy


To maximize pipelined parallelism within both large and small regions, the data can be broken up into its fundamental units, and spread out and gathered up at various steps in the pipeline. I.e, a GPU should start processing the first batch of a region as soon as it is available, before the other batches in a region are finished.




Pipeline Execution Framework


To support this fine-grained pipeline strategy, I developed a custom framework, the Pipeline Lib.


In this framework, each worker is a python generator that iterates through inputs the upstream worker and yields results to the downstream worker.





These workers are linked together in a list which is passed to the execution method





Advantages:

Since the interface is so simple, a number of parallelism methods and buffering strategies can be supported by the backend, and configured per-task.
The tasks can be composed at runtime, allowing for easy mocking, reusable components
The python generator syntax allows for the one-to-many and many-to-one steps that are required for the fine-grained parallelism concept
Disadvantages:

Need to maintain a homegrown framework


Minimizing Turnaround Time


If more work is pulled from the distributed SQS queue before it can be processed by the specific classifier instance, end user turnaround time will be impacted. Turnaround time is an essential engineering objective, and any compromises in this area should be taken carefully. The proposal takes a no-compromises approach to this important objective, with a near-optimal solution.


The proposed solution is to maximize back-pressure in the pipeline by implementing a sort of negative queue size in the pipeline. That is, producers should block until consumers have finished.


This is implemented via a unique feature of the Pipeline Lib. The idea is that the “packets_in_flight” argument is like a queue buffer size, but the consumers take up space on the queue. So if the process is consumer bound, it will look like this:






Solution 2: Configure a single producer + pre-processing worker that sends messages to the GPU worker. (will download/preprocess all data sequentially). GPU worker has a finite length output queue which will block if post-processing is a bottleneck.




























Can Pipeline Only Strategy Work Well?


Pipeline parallelism has many practical complexities in the scope of production techcyte classification.


First, consider the architectural constraints implied by a pipeline strategy (if it breaks any of these, it can’t be said to follow the architecture):


No information about a command’s processing status can be passed back to previous processing stage
All information about a command’s status must be passed on to next stage of processing
No multi-processing with a pipeline stage (kind of defeats the architecture)
Only very simple multithreading within a stage (e.g. multithreading pool to download model files)

These constraints have pose a number of concrete problems:


Problem 1: Logging/Error status


If you include the command logs and the command exit status in the above dependency graph, it looks more like this:


 

The proposed solution it to simply explicitly use a python context guard to capture the logging and send it to a system-wide file:




This context guard needs to be explicitly activated in every worker. Note that it can also catch errors and patch error statuses to the command, if necessary. It can also attempt to occasionally upload logs (though this can hurt performance, and is not implemented currently)


Problem 2: Autoscaling protection


Autoscaling protection needs to be turned on whenever there is work being processed somewhere on the machine, and turned off when there is no work.


The proposed solution is to simply stop reading SQS messages every few minutes.






Problem 3: Batching


How to send messages to GPU in batches of scenes/tiles? How to gather up results coming back from the GPU into full region/command level data?

Solution: Similar to maintaining state:
Batch contains full region/command level metadata
Post-processing steps collects all results belonging to a region
If they don’t get as many results as they would like before the next region comes along, error
See tile_crop_batch_regions and merge_tiles_into_regions functions in the implementation for more details



Testing Strategy


Risks to production classification:


Major reduction in model accuracy—model results completely unreliable
Small reduction in accuracy in production model: any new false positives or false negatives
Any changes at all to classification, including individual pixel changes or 1e4 changes in confidence (is this important for some human verticals that have stringent regulation)?
Existing production model breaks/can’t load after code changes
Classification is much slower than before
Metrics/logging/etc don’t work (but don’t crash)

Test suite concepts:


Regression test with locked model (Risk 2+3)
E.g. gold-standard tests
Sanity check against production model (Risk 1)
E.g. region with 15 objects, make it finds at least 5 true positives and 0 false positives
Smoke test against production model (Risk 4)
Things work start to finish, accuracy not evaluated
(Risk 5) Can we make classification infrastructure less sensitive to performance degradation? I.e. boot classification instances faster + adjust autoscaling rules appropriately to react faster to queue messages?
Integration tests + component tests (Risk 6)

Practical concerns:


Are regression tests too slow to run on CPU machines (can we make work small enough?)
CPU machines may not have all features GPU machines can have
Example: Fp16 convolution not implemented for CPU in pytorch, only GPU
Small numerical error in implementation details might create large, hard to check regressions
Can this be mitigated by approximate diffing?








Unified training/production API


Goals:


Maximize batching capabilities
Allow for classifying subsets of large samples
Especially important for classification v2 concepts where upstream services will need to have a considerable degree of control over how classifier works
Minimize number of cases to cover in testing

Generic classifier format:


Model-id
Command-id
results_location: Optional[str]    (if specified, uploads objects as json to s3)
holdout_run_id: Optional[str] (if specified, objects are associated with a “training_run_id”)
Regions (list)
region_id
z_stacked_regions
quadrants
[x_start,y_start,width,height]



Legacy classifier format:


Model-id
Command-id
results_location: Optional[str]    (if specified, uploads objects as json to s3)
holdout_run_id: Optional[str] (if specified, objects are associated with a “training_run_id”)
region_id
z_stacked_region
sample_id













Experimental Classifier Deployment


Objective: ML research team should be able to deploy prototype model architecture changes to classifiers for testing inside training tier without merging in code to production classifiers.


Solution 1: Fork repository


ML research team maintains experimental fork of classifiers in a separate repository https://gitlab.com/techcyte/training/classifiers 


This repository will only deploy to training, and will deploy to a slightly different endpoint. The training pipeline will be able to


Solution 2: Deploy experimental branches


Do what the frontend does and deploy real infrastructure from experimental branches:





















Appendix 1: Alternate parallelism strategies


Instead of focusing on pipelining, you can also utilize other parallelism strategies. However, these have problems


Threading only (not recommended)


The easiest way to parallelize any problem is with threading, to put each large chunk of work, (in this case, the command), onto a thread, where it will run sequentially to completion. However, the problems with this strategy are too great, and I cannot recommend it.




Benefits

OS schedules all parallelism; to programmer, all code looks sequential
Problems:

GPU memory strain
Latency/throughput tradeoff: More workers mean slower individual processing
Processing a single region happens sequentially—slow latency for processing an individual region


Threaded + Separate GPU worker (not recommended)


To deal with limited GPU memory, and to allow for concurrency between pre-processing and GPU classification on a single sample, we could have a separate GPU worker which is shared among the command threads. Unfortunately, this leads to difficult tuning of the number of workers, and complex error handling, and I believe there is a better strategy.




Benefits:

GPU memory conserved
Pre-processing + GPU classification can happen in parallel even on a single region
Problems:

Latency/throughput tradeoff: More workers mean slower individual processing
More complicated error handling
How should the GPU process detect if there are errors in a worker it is sending a message to?
How should worker processes detect if there is an error in the GPU process?


Appendix 2: Python-dl classifier data dependencies


While I was learning how the python-dl classifier worked, I tried to figure out all the data dependencies and config each step in the pipeline, assuming you wrote it as a pipeline, rather than a knot of threads passing data back and forth over queues. This diagramming effort was a significant inspiration for this work. This is only a partial part of the pipeline, and misses some complexities.


