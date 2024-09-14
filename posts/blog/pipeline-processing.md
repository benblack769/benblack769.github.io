---
title: "High Performance Pipeline Processing in Python"
slug: pipeline-processing
under_construction: true
excerpt: "Building a new high performance pipeline processing tool in python, using low-level multi-processing features and advanced python pickling protocols."
comments: false
share: false
priority: 1
img: /images/pipeline-processing/pipeline_diagram.svg
post_date: "2024"
---

Every software development advice usually starts with: *"Don't reinvent the wheel"*. I like this advice, but it isn't perfect. Occasionally, there seems to be a gap in the tooling: you want a wheel, but there only seem to be sleds or Conestoga wagons available. i.e. the appropriate high level tooling just doesn't exist (everyone custom-builds their own solutions), or is simply overly complex (existing tooling requires complex configuration with many sharp edges and potential bugs).

Once the opportunity to add something new is identified, then there is the challenge of implementing it in a way that can be useful in real projects with all the challenges and constraints of real world software. I was quite pleased with how this pipeline processing project turned out, and I'm hoping to share this experience in incremental tooling development. 

### The Call to Adventure: Encountering costly but rewarding problems

Every new idea starts with a challenge, an uncomfortable situation, where there is uncertainty, risk, and potential rewards. A call to adventure.

In this case, there was this dungeon of complexity around this ML inference pipeline that I worked on in 2021. This inference system was a distributed queue-worker based system. Each GPU worker was also optimized to maximize efficiency and reduce costs. However, the worker was optimized in a half-hazard manner, using knots of deeply nested and overlapping mess of multi-processing, multi-threading, pipes, queues, events, error handling, etc. After the original developer was promoted out of the team, the code was broadly viewed as incomprehensible and unmaintainable, and every one of us warrior coders gave up on solving the existing race conditions, unintuitive dependencies, infinite loops, deadlocks that were probably in the code, and instead hacked on an increasingly deep nest of timeouts, retries, and other failsafes to whack the sputtering engine into chugging along as best as possible.

But at the end of the tunnel was treasure---in this case:

1. The ability to actually change the code to be more general and more future-proof without fearing the goblins overwhelming us during the process (shocker)
2. The hope of a more robust system with fewer intermitted stalls and crashes. 
3. Clear, measurable inefficiencies in GPU utilization, with immediate AWS cost savings on the order of tens of thousands of dollars a month.

This treasure was clearly valuable across the engineering group, and quite visible to leadership, so the hurdles to adoption 

Despite this potential treasure, and its visibility, simply formulating a plan to solve the problem perfectly was beyond any of us working there, as there were too many constraints, and too many technical issues. Business and regulatory commitments to never change any results of any existing models, a codebase that couldn't be iterated on without breaking something, and a lack of a clear mission stymied any serious planning. 

However, I am not the type of person to stop when things seem uncertain or impossible in the world of software. Instead, I am compelled to push forward into the unknown. So I traced every logical codepath, and diagrammed it out into what seemed like the logical abstraction: a data processing pipeline (below). It wasn't pretty, but it made me understand the inherent simplicity to the logic. The cave was dark, but not too deep. 

![Classifier-diagram](/images/pipeline-processing/images/techcyte-pipeline.png)

At this point, without a clear directive, and with other tasks pulling at my mind, I sat on this for about 6 weeks, pondering it occasionally, and slowly gaining confidence for the next step. 

### Gearing for the Last Boss: Prioritizing the hardest problem 

"Python multiprocessing bug". This phrase tends to strike anxiety into the hearts of even those software developers experienced with multithreading in other computer languages or systems. It certainly struck some anxiety to all of us working on this system. 
<!-- Even Guido Von Rossum, the creator of python seems to view this subject with a bit of hesitation, in an interview after leaving his position as the BDLF of python, Guido von Rossum mentioned the relief he felt of not having to triage bug severity of (a random example he mentions) "multiprocessing bugs".  -->

And it isn't just that we were particularly bad at it. Most python-based high performance data processing frameworks includes "multiprocessing support" as a cool add-on feature to improve performance (i.e. pandas, scikit-learn, dagster, ray, etc). Unfortunately, in seemingly every single one of those systems, this feature has an long trail of bug reports, performance concerns, and other usage difficulties. These difficulties often add up to hundreds of hours of wasted effort from downstream developers, and stress that could have been avoided simply by using another language. And so python multiprocessing is often one of the major issues that pushes developers to look for an alternative to python, even at great expense and losing the great advantages of python's incredible computational ecosystem.

But what if we started from scratch, and built a micro-framework architected specifically around python multiprocessing difficulties, rather than trying to add in support later? What if we geared up to face the last boss, from the very beginning?

Luckily, I had a great deal of prior experience with python multiprocessing, from my prior experience building [PettingZoo multiprocessing wrappers](https://benblack769.github.io/posts/projects/supersuit/). I also had solid academic knowledge of low-level OS provided primitives to share data and synchronize processes, from TAing a course on the subject during grad school. And some basic knowledge of the underlying guarantees the hardware provides for cross-thread memory consistency. 

The experience led me to know some of the core issues that cause most of the pain, bugs, and poor performance that other libraries encounter. I.e. I had scouted the last Boss's special attacks:

* **Unhandled Segfault:** Many computational tools in the python ecosystem are C/C++ extensions prone to segfaults. These segfaults completely bypass all normal python exception handling, and ruin most multiprocessing error handling schemes.
* **Mismatched error propagation:** Even with normal python exceptions which are handled by all libraries, propagated errors when multiprocessing is enabled can look different than errors when multiprocessing is disabled, often leading to discrepancies in test and production environments. 
* **Excessive memory cloning:** When a new process forks, it takes a copy of the entire process image, even the stuff it will never access and doesn't need. This often leads to programmers limiting the amount of parallelism far below the capacity of the CPU, just because memory is constrained instead. And no, in python, the OS support for copy-on-write memory clones does not fix this very well for some reason, perhaps due to python's cyclic garbage collector passes.
* **Spawn multiprocessing overlooked:** Spawn multiprocessing is the only officially supported method on MacOS, and is also the preferred method on Windows. However, spawn multiprocessing re-constructs the entire python runtime environment, resolving imports which requires running the script section of the python code, meaning that stateful behaviors in the script section of the python environment are vulnerable to bugs and problems. Combined with linux-heavy dev teams, this overlooked technical challenge can lead to lots of mac/windows specific bugs occurring.
* **Excessive usage of unix pipes for bulk data transfer**: Unix pipes are a powerful abstraction for inter-process communication. However, they are built on-top of a 65k buffer, which creates a lot of unnecessary back-and-forth process chatter which slows down the data transfer significantly. Their implementation also includes a large set of locks, kernel context switches, and other sources of overhead that reduces their performance even for smaller data transfers.

With a commitment to focus on these system/runtime problems, rather than ease of use or software design principles, the design fell into place quickly.

1. This would be a microframework that fully controls how and when processes are spawned, errors are handled, and messages are passed. Users will only have access to a fixed set of configuration to change semantic behavior. This decision goes against many of my closely held software design principles, but it seemed like the only way to make sure every one of those failure cases were handled. 
2. The core microframework would only support a single very simple concept: linear async message passing between workers. All other features and functionality would be built on top, either in the form of coding patterns, or in the form of wrappers with a higher level interface with more features. 

With this basic design in place, the implementation of the core functionality, while low-level and tricky due to the optimizations implemented <!-- TODO: Add reference to low-level tricks in readme -->, was possible to implement in only a few hundred lines of code in a single. Even more importantly, this simplicity allowed for fairly exhaustive testing of configuration options and many exceptional cases of segfaults, spawn multiprocessing, and error catching. 

Performance turned out pretty good as well: when fixed-size buffers are enabled, tens of thousands of short messages can be passed per second, and several gigabytes of total message bandwidth for larger messages. Process spawn time is typically well under a second, and shutdown triggered by either exceptions or segfault typically also typically well under a second. There are no busy loops, so CPU overhead is very low. All with a pure-python implementation with only pure-python dependencies.

With a customized build and gear designed specifically to tackle the last boss, it should be a breeze. Now it is time to turn our attention to everything else. 

### The Dungeon Needs a Walkthrough: Building implicit feature support with examples and tutorials

Software development is much like game development: there are a few hardcore devs out there who want to solve every problem themselves, but most people just want to complete the challenge, regardless of what help they receive. So when you have a micro-framework like this, it needs to have easy, established ways to solve most common problems brought to it. This does not always require code: typically documentation, examples, and tutorials provide the necessary solutions just as effectively. 

The easiest, and in my experience, the only way that really works well is to just write guides for the rooms and minibosses in rooms that you and your collaborators have already explored, and hope that they are useful to others. 

So after some dungeon crawling through the exiting production codebase that inspired the project, trying to smash my head against every single feature of the existing code, even if minor, or a convenience feature, or a significant performance optimization and translated it to this pipeline concept, I ended up with a less detailed, but more functional diagram of everything that easily fit into the pipeline concept, and the few things that didn't:

![job monitoring diagram](/images/pipeline-processing/images/job-breakup-monitoring.png)



This means that the whole problem needs to be scouted, so we know we aren't going to drop the ball on a lesser challenge. 

When dealing with incomprehensible code, it can be good to try to roughly sketch out each conceptual component, i.e. de-construct the code, and try to re-conceptualize of the problem the code is trying to solve. First, I modeled the code as a pipeline, as any pipeline worker will be mostly stateless, and the processing took many steps. Second, I dived into the code, and tried my best to manually translate the crazy mess of queues and multiprocessing into this rough processing diagram:


I sat on this diagram for a few weeks while I focused on other tasks, and when I turned back to this problem, this diagram gave me the mental structure and confidence I needed to really invest in building out this high level pipeline processing framework.



In this case, 

This phrase *"Don't reinvent the wheel"* is typically used to encourage people to research existing technologies and existing high level tooling. The end goal is to get engineering teams focused on business problems, which have innumerable nuance, over technical problems, which usually have been modeled abstractly and solved pretty darn well in some surprisingly general situations.

However, I occasionally see value in deviating from this norm and building out new, abstract high level systems with low level tooling. However, it is best to ensure that:

1. There doesn't seem to be any solid solution to the problem in the open source world. Complex creativity seemed to be needed in one form or another, either in the form of workarounds or compromises.
1. This problem can be modeled with some (perhaps novel) high level abstract framework, and separated into a library in a distinct codebase with its distinct set of tests and release process. So the low level complexity can be contained to one codebase, and other codebases will not need to know the low level implementations details.
1. To avoid leaky abstractions, this abstract problem should be robust to a variety of errors, and should be solved in full generality with high efficiency and low absolute resource utilization.  Again, the importance of building this high level interface is to get engineering teams discussing and researching business problems, rather than nuances in implementation, so it has to work well out of the box. 

### Problem inspiration

### The high-level pipeline-processing API

After a few weeks, I converged on this idea of creating a high-level pipeline processing framework that could solve this processing task, and similar tasks, without any manually managed parallelism or synchronization constructs.

When designing the high level API, I thought of the most familiar way of achieving pipelining in unix: the command pipe.

```
$ cat sample.a | grep -v dog | sort -r
```

I remembered this idea I got from my previous employer that python generators are the most pythonic equivalent of unix pipes. Each "command" is turned into a generator which accepts an iterator, and returns an iterator:

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

The bad news is that, unlike unix pipes, python iterators are evaluated completely sequentially. The good news is that iterators work on high level objects, which means we will have way more control over buffering, backpressure and parallelism when configuring the pipeline.

To maximize the amount of control over message passing and error propagation (which is surprisingly hard to do right in a multi-processed system), I went ahead and wrapped these generators in a big task definition, which is passed to an execute command that runs the whole pipeline. Like so:

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

The main design goals were:

1. Foolproof by default: infinite buffer support, zero backpressure (no parallelism) by default, etc.
2. Options to make it as fast and as parallelized as possible, even at the cost of some leaky abstractions (i.e. opt-in shared memory buffers that can be clobbered if not used properly).
3. Simple but flexible API, encouraging high level feature addition by composition, not extension.

The main challenges that required low level involvement were:

* Ultra-fast message passing between processes.
* Negative-sized buffering: See [Appendix B](#appendix-b) for details



### Low level design

While the code is a better place to go if you want to see all the low level details, I can outline the broad low level features I used and various traps that needed to be avoided:

#### Low level Goals

* No busy loop: Minimizes overhead and maximizes responsiveness of pipeline
* Maximize data throughput efficiency
* Reasonable message passing overhead 

#### Low level Technologies

* Preallocated shared memory using [`multiprocessing.RawArray`](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.sharedctypes.RawArray) and [`multiprocessing.Value`](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Value)
* [Pickle v5 out-of-band-buffer protocol](https://peps.python.org/pep-0574/) to maximize read/write efficiency to that shared memory. Only supported in python 3.8 and above. Gets 3-4x performance improvement for large buffers vs ordinary pickling.

#### Custom components

* Runtime type checking to ensure that the pipeline steps are consistent with each other
* A fixed size shared memory buffer for fast, asynchronous communication
* A slower, pipe-based asynchronous communication system for unbounded, foolproof communication.
* Custom ring buffer protocol to match up many producers to many consumers via a fixed number of buffers. This protocol also enables the negative backpressure capabilities of the system using clever semaphore usage.
* Unit tests testing a variety of hard cases and crashing behavior, including sigkill and sigint handling.

#### Traps

* python's standard library [`multiprocessing.Queue`](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Queue) spawns a new thread ([source](https://github.com/python/cpython/blob/635184212179b0511768ea1cd57256e134ba2d75/Lib/multiprocessing/queues.py#L94)) on the writer end of the queue to push messages through. While this brings nice performance and simplicity benefits, this thread introduces some nasty race conditions if the reader or writer process suddenly exits. This was solved by re-implementing the queue except optimized for one-to-one communication and robust error handling, and then adding a second ring buffer layer on top of it to coordinate the many-to-many connections. 
* Segfaults and Sigaborts triggered by native C packages bypass python's exception handling system, and are quite common when working with GPU packages, so we need to be able to detect and respond to process exits regardless of the reason. The low level [`multiprocessing.connection.wait`](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.connection.wait) function was used to detect process exiting under any conditions without a busy loop.

### Full framework configuration 

The complete list of the configuration for a pipeline task is simply:

* `num_workers`: Number of parallel workers spun up to assist in this pipeline task. (Default: 1)
* `packets_in_flight`: Allowed backpressure before the writer processes start blocking. If set to `num_workers`, then the reader process has to request the next packet before the writer thread even starts processing, disabling parallelism completely for the reader process. Must be at least `num_workers`.
* `max_message_size`: If set, it uses the fast fixed size shared buffers instead of a pipe to transfer data. Improves transfer speed by ~3-4x for large packages and ~2x for small latency driven packages (Default: None, i.e. infinite)
* `shared_buffer`: Only configurable once `max_message_size` is set. If set to true, disables copying the shared memory buffer to a local buffer on read. If set, the user must understand that any references to earlier pipeline steps might be invalidated once the read iterator steps. (Default: False)


### Justifying the framework

At this point, the framework was more or less ready to use from a technical perspective. The next barrier to built it into our system was a human one. 

Real world code is always developed in the context of a team of talented individuals with differing ideas of what considerations are most important when developing code. I ended up receiving pushback from:

1. *The CTO:* Thought that a high level framework like this would decay in quality and increase in maintenance cost over time due to feature-creep.
2. *My supervisor:* Thought that the pipelined parallelism model created more complexities than it was worth, preferred his own custom parallelism that he implemented in a prototype.

To move forwards, I had to craft a solid argument explaining:

1. Why pipelining was the best way to parallelize this system, given the alternatives?
2. Why would new framework was needed to be successful in meeting project goals?
3. Why wouldn't this framework degrade into something unmaintainable and awful in the long term?

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

Unfortunately, the pipeline model introduces two new difficulties that don't occur in independent parallelization:

1. **Logging:** Logging needed to be isolated per-command. So the information log information needs to be tracked from pipeline task to pipeline task. We ended up implementing this outside the pipeline framework by appending to a temporary files in the filesystem, using a coding pattern described in  [Appendix A](#appendix-a).
2. **Error handling:** One job encountering a recoverable, job-specific error, such as an API failure during upload or download, or a decoding error on a corrupt image input, should not interrupt the other commands running in parallel. This was solved outside the high level framework using a code pattern described in [Appendix A](#appendix-a).
3. **SQS visibility extension:** 
4. **Autoscaling protection:** In the distributed queue, each instance is booted up with autoscaling rules. However, if it takes in a job that takes 20 minutes to process, then we risk the autoscaling system terminating the instance in the middle of the job. While SQS will restart the command after awhile, we observed 3-4x increased processing time and cost when not using autoscaling protection. However, we need to be very careful to shut down autoscaling protection when waiting for a new message to come in, so the cluster can be downsized according to the autoscaling rules. While autoscaling can be turned on easily when a new message is being read, how do we known when to turn it off? The way we ended up going with was to ocassionally clean up the whole processing buffer.
5. **Batching:** The GPU's matrix multiplication operations work most efficiently when it is given as much work it can handle within its memory constraints. This requires batching. Luckily, almost all of our work was larger than a batch, so this became a work subdivision problem, rather than a grouping problem. The subdivision looked something like this: ![batching-diagram](/images/pipeline-processing/images/work-division.png) Work was subdivided into different pipeline jobs, and then grouped back together in later jobs. While having dependent jobs makes the programming paradigm somewhat more difficult, specifically, the grouping pipeline tasks need to be carefully handled, and only one such task can be spun up.


## Appendix A

Error handling/logging coding pattern.

```python
def pipeline_step_generator(input_messages: Iterator[Message]): 
    for input_msg in input_messages:
        # the message_guard is a function on the message class
        # that returns a context guard that opens up the
        # message specific, cross-pipeline logger file for appends 
        # this guard also catches exceptions in the __exit__ function to report 
        # errors to the user more quickly
        with input_msg.message_guard():
            # do all processing here so that logs and errors are caught
        # the yield statement is outside the context guard because:
        # 1) the logger file should be closed before the next pipeline step re-opens it for appends
        # 2) any exceptions should be reported by the context guard
        # in the step that raised it, and shouldn't be reported here as well when the framework errors the process
        yield output_msg
```

## Appendix B

### Negative buffering support

Negative buffering allows the user to carefully control the total amount of buffering in a long pipeline with many steps, which was key in the application of a queue worker with many post-processing steps.

What negative buffering does is disable parallelism in between steps, by blocking producers execution (when the producer sends a message) until consumers ask for another message. Since the producer will not start working on the next message until the consumer is asking for it, these two steps will operate in sequence. 

This is implemented generically alongside regular buffering by a concept of slots, each of which is owned by either a producer or a consumer.  In the below case, the producers have filled all 7 slots, and so they are blocked, even though the consumers are actively working on two of the slots. Note that this buffer has a normal buffer size of 5. 

![consumer-blocked](/images/pipeline-processing/images/consumer-blocked.png)

Note that this pattern also allows the consumers to read directly from the slot's shared memory buffer, without copying, although this does introduce some risk of reference clobbering if references to the memory are stored between pipeline step executions.
