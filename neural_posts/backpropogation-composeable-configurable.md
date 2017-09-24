## Neural Networks: Managing complexity in machine learning models

### Inspiration 1


I know a few people knowledgeable about machine learning who tend to disregard neural networks as one technique among many, and who think that they will soon be obsolete, just as the things before neural networks were obsoleted by them.

However, I feel that neural networks are fundamentally different than other machine learning techniques.

They seem to have fundamentally lifted barriers that have been there before in image and speech recognition, and brought these problems to new levels of capability, which you can see transforming our technology and our world.

New areas of application, such as translation, robotics, and music generation, are seeing the same trend we saw in image and speech recognition 5 years ago, and I think they have similar levels of promise, even if it may take longer for them to develop (since there is less money in those areas).

So why does this approach seem so much more promising than other approaches? Why is it breaking barriers in areas many experts never imagined it could be applied to?

Some of the reasons are fairly mundane ways that allow people to work with and exploit the extreme complexity of modern neural networks.

* There are now sophisticated software tools specifically built to help research in neural nets (tensorflow, theano, torch).
* There are a great number of tunable hyperparameters, which have decent level of independence, allowing for effective tuning.
* There is a great deal of research trying to improve many different parts of neural networks

But these feature are also more or less true for other methods, like Support Vector Machines.

So looking deeper into neural networks, and what has succeeded, and what has failed, I am led to believe that there is a much more fundamental reason for their success: *Backpropagation can work with any differentiable functional form*

There is a lot there, and the power of that statement is not obvious. Lets look deeper into why allowing arbitrary functions is extraordinarily powerful. 

### Inspiration 2

When looking at machine learning tasks that neural networks have been applied to there is a pattern.

1. Neural networks are successfully applied for the first time. Are close to as good as state of the art models.
2. State of the art models are inspired by neural networks to get better
3. Neural networks are more carefully tuned for the model, beat state of the art models soundly.
4. Neural networks are adapted in many non-trivial ways to incorporate ideas from old models, beat previous NN models.
5. Standard neural networks mature, dominating all clever tweaks and twists.

What I am most interested in is that last step. Why do standard NNs completely end up completely dominating in the end?

Another way of putting this is:

What barrier is there that standard NNs can break, and other methods are held back by? And how do NNs break this barrier?

### Inspiration/goal 3

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

Lets say that $$y(x) = x + \epsilon$$, where $$\epsilon$$ is some random error. The identity function is an extremely simple function that should be easy to learn. However,

*show how noise increases relative to the size of the internal vectors, and also the size of the matrices*

### Power of neural networks

*give an indication to how depth and size of neural networks increase the types and complexity of functions that NNs seem to tend to solve*

### Backpropagation

*explain how backpropagation allows you to treat different layers of the network as independent learning problems (taking into account the noise problem above)*



At its core, backpropagation is simply the chain rule from calculus.

So why is this important?


*Overview of chain rule.*

Chain rule is simply when given two functions $$F$$,$$G$$, the derivative of $$(F(G(x)))^\prime = $F^\prime(G(x))G^\prime(x)$$.

*Draw a diagram about composition of matrices.*

*Talk about how you can compose matrices naturally in trivial ways. Bring up deep networks, m.*

*Bring up the conflict between model flexibility and model noise. Then talk about how convolutional networks are a great example of a nontrivial version of this tradeoff.*

*Another possible one is sentence decomposition, ie.e the function applied to each word and the the binary output as a function of that concatenation of outputs.  Is a more trivial example.*


*Then talk about LSTMs. Talk about how they are a non-trivial one, but rely on the same basic intuitions. Show how LSTMs operate in much the same level as single matrices blocks.*

*Talk about how now people use LSTMS as building blocks for more on nontrivial things like the google translate algorithm*

### Gradient Descent

*Explain how gradient descent can be improved through low dimensional examples*

*show how it can solve some of the problems with magnitude reduction associated with deep layers*

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
