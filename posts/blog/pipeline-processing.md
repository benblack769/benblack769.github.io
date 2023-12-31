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

Every software development advice usually starts with: *"Don't reinvent the wheel"*. I like this advice, but it isn't perfect. Occasionally, appropriate high level tooling just doesn't exist, or is deeply inadequate. I was quite pleased with how this pipeline processing project turned out, and hope it can be used as a model project for how a new, abstract high level processing tool should be developed.

### When should we reinvent the wheel?

This phrase *"Don't reinvent the wheel"* is typically used to encourage people to research existing technologies and existing high level tooling. The end goal is to get engineering teams focused on business problems, which have innumerable nuance, over technical problems, which usually have been modeled abstractly and solved pretty darn well in some surprisingly general situations.

I try to follow this advice as closely as possible:  to use high level tooling, to keep code simple and free of low level complications, and to optimize performance within the limitations of common usage patterns with those high level tools. However, I occasionally see tremendous value in deviating and building out new, abstract high level systems with low level tooling. However, I only do so when:

1. There doesn't seem to be any solid solution to the problem in the open source world. So some complex creativity is needed anyways, either in workarounds or compromises.
1. This problem can be modeled with some (perhaps novel) high level abstract framework, and separated into a library in a distinct codebase with its distinct set of tests and release process. So the low level complexity can be contained to one codebase, and other codebases will not need to know the low level implementations details.
1. To avoid leaky abstractions, this abstract problem should be robust to a variety of errors, and should be solved in full generality with high efficiency and low absolute resource utilization.  Again, the importance of building this high level interface is to get engineering teams discussing and researching business problems, rather than nuances in implementation, so it has to work well out of the box. 

### Problem inspiration

[PUT CLASSIFIER DIAGRAM HERE:]

The inspiration for this problem comes from a ML inference pipeline that I worked on in 2021. This inference system was a distributed queue-worker based system. Each instance had its own pipeline with 6 main steps: Pulling, pre-processing, GPU inference, post-processing, and Upload. Pre-processing and post-processing were CPU intensive, pulling, download, and upload were high latency, and GPU inference was clearly GPU heavy. 

The constraints were:

1. GPU memory was already pushed to the limits, so we could only run one process on the GPU at a time.
2. We do care a bit about latency, and some jobs were very slow (30 minutes to process a single job) so we can't pull batches of jobs without care. However, adding a few seconds of latency isn't an issue.
3. Some jobs are very small, executing in 0.15s on the GPU. So absolute overhead is a concern.

### Pipeline abstraction

A common parallelism pattern for efficient, latency sensitive, memory sensitive, variable sized work like this is a simple, linear pipeline processing with configurable backpressure. My research couldn't come up with anything adequate, so 

So I hoped to create a simple, parallelism

