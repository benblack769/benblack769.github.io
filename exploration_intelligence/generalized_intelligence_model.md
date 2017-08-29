## Generalized Model of Intelligence

### Preface

This model is supposed to meet the requirement set out in [this page](exploration_intelligence/generalized_intelligence_requirements), while learning reasonably quickly. So glance over those if you haven't already.

The approach described is deeply and subtly inspired by neural networks, and I will reference the terminology. Before continuing, I suggest reading an introduction to basics like backpropagation and gradient descent, how deeper learning works better than shallow learning etc. Much of this will be covered in my introduction to Neural Networks on my site eventually.

### Introduction

While there are current techniques that could maybe be used to solve this problem to some degree, I wanted to try to explore this for myself, so that I could get a more intuitive understanding of the subject. In particular, I wanted to gain a deeper understanding of learning problems like long term memory and meta-intelligence, which I hope to solve one day.

### Formalizing requirements

#### Inputs

There are two different kinds of inputs to the intelligence during each time step.

1. Sensory inputs (touch, smell, sight, etc.)
2. Global cost

Following standards in neural networks, I will model sensory inputs with a vector of positive floating point numbers, and the cost is also a floating point number.

However, to make this less reliant on outside parameters, and therefore easier for a programmer to work with, there is no particular limit to the magnitude of the cost or senses, as long as they make sense in relation to each other and over time.

### Outputs

The outputs are motions




s
