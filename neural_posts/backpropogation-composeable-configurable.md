## Backpropagation

Neural networks have been praised as one of the most flexible machine learning tool, and indeed algorithm of all time. However, if you look more closely, neural networks for different problem domains have significantly different structure. So why do people think they are flexible? What makes people think that they are so powerful?

The answer lies in the flexibility and configurability of the core algorithms: gradient descent and backpropagation of error.


### Vanishing gradient problem

Vanishing gradients are the real bane of neural networks, causing trouble with deeper networks, including recurrent networks, which are used for time series data. The cause is quite simple, if you look a the variance of the outputs, given some distribution of inputs.

A standard neural network

Lets look at NNs very carefully.

Look at a 2 layer network

Let $$x$$ be the vector of input elements, and $$y$$ be the vector of output elements, and construct matrix $$A$$ such that $$ A_{ij} \sim N(\mu, \sigma)$$.

$$ \hat{y} = f(x*A) $$

Now, going to three layer network (two matrix network). Call the second matrix $$B$$.

$$ \hat{y} = f(f(x*A)*B)* $$

From this view, I hope to demonstrate the vanishing gradient problem.


Lets say that {% raw %}$$y(x) = x + \epsilon$${% endraw %}, where {% raw %}$$\epsilon$${% endraw %} is some  the identity function. This is an extremely simple function that should be


### Backpropagation

At its core, backpropagation is simply the chain rule from calculus.

So why is this important?



Overview of chain rule.

DiagraDraTalk about composition of matrices.

Talk about how you can compose matrices naturally in trivial ways. Bring up Depp networks, m. Then talk about how convolutional networks are the a nontrivial version of this.

Another possible one is sintane decomposition, ie.e the function applied to each wor,d and the the binary output as a function of that concatenation of outputs.  Is a more trivial example.



The talk about LSTMs. Talk about how they are a non-trivial one, but rely on the same basic intuitions. Show how LSTMs operate in much the same level as single matrices blocks.

Talk about how now people use LSTMS as building blocks for more on nontrivial things like the google translate algorithm

### Gradient Descent

Now lets look at gradient descent, and how we might hope to solve some of the problems in backpropagation with techniques here.

### Conclusion

Neural networks are really complicated. I hope that this paper will not make anyone think that neural networks are easy to configure to new problem areas, because they are not. In order to build a new network, you need to establish

* algebraic structure
* sizes of the matrices
* gradient descent algorithm (and associated hyper-parameters)
* cost function
* Preprocessing input/output

All these things are highly non-trivial problems (the parameters and sizes are especially tricky), and take a lot of work to get them good enough to beat the current cutting edge techniques.

When you consider how slow training is, the process of developing all of this can take months.

Many of the doubters think of this complexity as a serious weakness of neural networks, and a sign that other techniques will soon supplant them.

The doubters so far have been proven wrong again and again.

The reason is because while neural networks are complicated at a holistic level, they can be composed nicely into different parts, different tradeoff, and different ways to specialize the problem to specific domains. Intuitive structures work amazingly well. Experts can build powerful intuitions about how the hyper-parameters interact.

beautiful algorithms that all do very different things , but based on fairly straightforward intuition allowed by the composition properties of backpropagation, and the constant ideas from gradient descent.
