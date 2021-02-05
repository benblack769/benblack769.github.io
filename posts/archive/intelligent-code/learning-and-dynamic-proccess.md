##

Idea: a small amount of learning can make a huge difference in a already intelligent dynamic system.

Just need to find the right intelligent system to make this work.

One possibility here to show superiority of actual learning over other methods is to show its superiority to things like genetic algorithms.


### Properties of a reasonable simulator

What sorts of problems do we want to see from this learner?

Reinforcement learning is only interesting in cases that have the following properties:

1. The cost function is a complex, non-obvious function of the inputs
2. The outputs actually interact with the environment.
3. Entities interact with each other.

Because I want to set this up as a simple learner, there will be no neural networks, or other types of complex interactions between variables. Rather, we will just have interactions between the cost, the internal variable, and the corresponding variable in other entities.

Environment description

* 

Variable descriptions

* Input variables
    * Other behavior variables
    * Current location value
* Internal variables
    * Fixed change in direction angle
    *
* Behavior variables
    * Desire to adopt other's variables
