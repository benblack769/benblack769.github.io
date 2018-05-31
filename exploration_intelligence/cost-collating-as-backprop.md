---
title: "Backpropagation in Nature"
under_construction: true
slug: cost-collating-as-backprop
excerpt: "Backpropagation is a simple, yet powerful algorithm used in deep learning. But natural intelligences do not appear to use backpropagation when learning. But the algorithms it uses instead can be seen as an approximation of deep learning. This approach has huge potential in distributed AI computing. If it is a close enough approximation, then it also may allow us to understand natural intelligence by studying deep learning."
comments: true
---

### Prerequisites

This assumes significant familiarity with the backpropagation algorithm. If you aren't familiar with it, please read [my explanation of backpropagation](/neural_posts/technical-backpropogation.md).

### Interpreting backpropagation errors

In any standard mathematical analysis of neural networks, the weights are everything. The nodes are just uninterpretable intermediate calculations. But the backpropagation assigns interpretable errors these nodes.
If you recall, these errors are the partial derivative of the node value when treating that layer as the fixed input.

This is best expressed through a layer centric analysis. Consider each layer of the network to be a function with an input and an output: the other layers do not exist. Then the error of a node in the layer is exactly the contribution of that node.

### Single layer to multi-layer backpropagation



### Recurrent single layer backpropagation


<!--The diagram below reminds us how they are laid out.

![arg](/images/backprop/diagram-svg/act-whole-backprop.pdf.svg)
-->
