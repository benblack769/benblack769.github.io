## Formalizing model

### Preface

Here I talk about implementation details involving the conceptual approach for the intelligence model laid out [in the previous post](exploration_intelligence/conceptualizing-model).

### Formalizing requirements as an API

#### Inputs

There are two different kinds of inputs to the intelligence during each time step.

1. Sensory inputs (touch, smell, sight, etc.)
2. Global cost

Following standards in neural networks, I will model sensory inputs with a vector of positive floating point numbers, and the cost is also a floating point number.

However, to make this less reliant on outside parameters, and therefore easier for a programmer to work with, there is no particular limit to the magnitude of the cost or senses, as long as they make sense in relation to each other and over time.

#### Outputs

The outputs are actions, motions, etc, that effect the "outside" world. This is also a vector of floats, but absolute magnitude is going to be relevant here. The interpretation is "the extent to which something moves." So when a programmer is making a robot, then
