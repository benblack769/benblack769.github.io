---
title: Backpropagation in four diagrams
under_construction: false
excerpt: "An intuitive yet formal description of backpropagation using diagrams."
comments: false
share: false
img: /images/backprop/diagram-svg/whole-backprop.pdf.svg
post_date: "2018"
priority: 1
---
#

Backpropagation is a procedure at the center of deep learning, the method by which gradients of the complex non-linear functions are calculated for all parts of the network. It is often overlooked in explanations of deep learning, especially in the last few years. This is unfortunate, as some very important issues in deep learning techniques, such as the vanishing gradient problem, require a full understanding of backpropagation, while many other techniques and issues require a partial understanding, including Xavier initialization, training memory consumption, and loss scaling for mixed precision training.


## The four diagrams

I made four diagrams which explain both the high level aspects and the low level aspects of backpropagation using simple and consistent notation and coloring schemes. At the end describing the vanishing gradient problem precisely using actual mathematics, rather than the usual handwaving, will be an easy exercise if you are familiar with the mathematical notation, rather than a serious chore only to be taken on by specialists.


### Forward propagation

First, forward propagation for a single node. A node is simply the sum of a number of weighted scalars in the input. The output of the node is passed through a scalar activation function. This value is then used as input to the next layers, though a weighted sum.

#### Notation

* $$I$$: The inputs to the neuron
* $$L$$: The linear part of the neuron: think of this as the accumulator for the weighted sum
* $$A$$: The activated
* $$O$$: IMPORTANT: these are the *linear* parts of the output.
* $$\sigma$$: The activation function. One common choice is relu.
* $$W^i$$: the weight matrix for the *i* layer.

![img](/images/backprop/diagram-svg/diagram.pdf.svg)

### Backward propagation

Next, backpropogation for a single node. Backpropogation is a recursive method where you start at the output and compute error backwards. Therefore, the key to backpropogation is that you assume you already have computed the error of the *output* layer, in particular the *linear* part of the output layer. You then weight that error to find out how much changing the value of the activated (non-linear) neuron would have changed the output. Finally, you compute the derivative of the activation function $$\sigma^\prime$$  in order to get the error of the linear part of the nueron, $$\frac{\partial L}{\partial c}$$.

#### Notation

*
* $$\frac{\partial O}{\partial c}$$: The degree to which the non-activated part of the output which contributes to the cost. Formally, the partial derivative of the output with respect to *c*.
* $$\sigma^\prime$$: the derivative of the activation function. For relu, this is just the step function which is one if greater than zero, and zero otherwise.

![img](/images/backprop/diagram-svg/diagram3.pdf.svg)

### Computing the cost

So, now that the individual networks are clear, lets look at the whole system. To start the recurrence relation of the backpropagation, you need a base case. This means you need an output neuron which is the cost. In a supervised setting this is computed by directly comparing the output of the network to some gold standard output which is considered to be correct. One common comparison is squared error $$cost = \sum_i (O_i - E_i)^2$$

![img](/images/backprop/diagram-svg/whole-backprop.pdf.svg)

### Backpropagating the cost

After computing the cost, you can use the single node backpropagation method to recursively compute the error of the previous layers.

![img](/images/backprop/diagram-svg/act-whole-backprop.pdf.svg)

### Computing the gradient

The real goal of backpropagation is to compute the output with respect to the weights, not the layers. Then the weights will be accordingly updated. But once you have computed the cost with respect to the layers, computing the gradients of the weights is simple.

$$ \frac{\partial W^k_{ij}}{\partial c} = A_i \frac{\partial O_i}{\partial c}  $$
