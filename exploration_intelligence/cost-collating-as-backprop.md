---
title: "Backpropagation in Nature"
under_construction: true
slug: cost-collating-as-backprop
excerpt: "Backpropagation is a simple, yet powerful algorithm used in deep learning. But natural intelligences do not appear to use backpropagation when learning. But the algorithms it uses instead can be seen as an approximation of deep learning. This approach has huge potential in distributed AI computing. If it is a close enough approximation, then it also may allow us to understand natural intelligence by studying deep learning."
comments: true
---

### Prerequisites

This assumes significant familiarity with the backpropagation algorithm. If you aren't familiar with it, please read [my explanation of backpropagation](/neural_posts/technical-backpropogation.md).

## What is Backpropagation?

In any standard mathematical analysis of neural networks, the weights are everything. The nodes are just uninterpretable intermediate calculations. But backpropagation gives these nodes errors.
These errors have mathematically meaningful interpretations. If you recall, these errors are the partial derivative of the node value . 

![arg](/images/backprop/diagram-svg/act-whole-backprop.pdf.svg)
