## Generalized Model of Intelligence

### Preface

This model is supposed to meet the requirement set out in [this page](exploration_intelligence/generalized_intelligence_requirements), while learning reasonably quickly. So glance over those if you haven't already.

The approach described is deeply and subtly inspired by neural networks, and I will reference the terminology. Before continuing, I suggest reading an introduction to basics like backpropagation and gradient descent, how deeper learning works better than shallow learning etc. Much of this will be covered in my introduction to Neural Networks on my site eventually.

### Introduction

While there are current techniques that could maybe be used to solve this problem to some degree, I wanted to try to explore this for myself, so that I could get a more intuitive understanding of the subject. In particular, I wanted to gain a deeper understanding of learning problems like long term memory and meta-intelligence, which I hope to solve one day.

## Formal approach

### Formalizing requirements as an API

#### Inputs

There are two different kinds of inputs to the intelligence during each time step.

1. Sensory inputs (touch, smell, sight, etc.)
2. Global cost

Following standards in neural networks, I will model sensory inputs with a vector of positive floating point numbers, and the cost is also a floating point number.

However, to make this less reliant on outside parameters, and therefore easier for a programmer to work with, there is no particular limit to the magnitude of the cost or senses, as long as they make sense in relation to each other and over time.

#### Outputs

The outputs are actions, motions, etc, that effect the "outside" world. This is also a vector of floats, but absolute magnitude is going to be relevant here. The interpretation is "the extent to which something moves." So when a programmer is making a robot, then

### Intuition approach: Self-analysis

talk about how it is always a good idea in AI (especially modeling intelligence) to figure out how you reason about a problem.

talk about how I thought of my how my own ideas formed, how I learned, etc. Talk about how I noticed headaches caused by continued muscle extension caused by overexertion, emotional change causing emotional exhaustion rather than the emotions themselves.

talk about how thoughts "travel backwards", linking memories back in time.



Mention how this is very difficult to formalize. make sure to link the ideas laid out here in the constructions in the later part of the post.

### Structure of the model

Diagram pointing things out like the inputs and how they take in different senses, the outputs, and how they represent different actions. Linear learner model.

### Dynamics of the model

This is the hard part:

#### Intuitive approach

Talk about special input and output, where the input is the magnitude of a variable following a tanh path, and the output is how much that variable should change in the next timestep. Perhaps forcing towards zero is a good stabilizer.

### Results from simple learning task

### Results for guess_letter

### Conclusion and further studies
