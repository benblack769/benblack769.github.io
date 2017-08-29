## Moving Towards a Generalized Concept of Intelligence

### Inspiration

I have always been a fan of SimCity. Awhile ago, I decided it would be neat to build a simulation of the world where all simulated behavior occurs at the individual level, instead of relying on models of broader societal behavior. After some thought, I realized that I would need the individuals to have some level of intelligence for this to work.

I started listing out requirements of this AI. At a basic level, each individual needs to be able to figure out what is best for itself, under a variety of different situations. Ideally, these individuals working for themselves will eventually learn how to work together in order to achieve mutual benefit, i.e. social behavior, or a hivemind.

And so I set out to create something which can model this social behavior by creating powerful individual intelligences.

Remember that the goal here is not to produce the most intelligent possible behavior, like in machine learning, but rather to produce behavior which reflects social behavior.

### Introduction

In order to think about intelligence, I decided to back up, and think about the many different intelligent things in this world. There are the ones we are most familiar with, human and animal intelligences. Although we don't really understand them, every day we learn something new. Within human intelligence there is conscious intelligence and unconscious intelligence (although how separate these really are is debatable). There are hiveminds, with each individual signaling to others in a way that drives overall behavior. Then there are the more bizarre intelligences: evolutionary intelligence, machine intelligences like IBM Watson, decentralized animal and plant intelligences, and more.

I believe that conscious, unconscious and social intelligence have a significant amount in common.

So what I want to do is build a model that, with minimal structural tweaking, can be used to simulate any of those intelligences. This way, I can use the same concepts for studying the individual and social intelligences, perhaps using the same code. We can also learn about some of the more unusual ones, such as hiveminds, and perhaps gain some insight into our real goals.

Also, making intelligence general like this will allow for a new concept of layering. Social intelligence wrapping over conscious intelligence wrapping over unconscious intelligence is tricky. But layering 3 similar learners in a hierarchy is simple to implement.

### Basic requirements

I realized almost immediately is that all these methods have most of the learning operating at a node level (except for certain machine intelligences). What this means is that nodes should be able to act and learn quite independently, without lots of interactions with other nodes.

What this means is that backpropagation, while powerful, will not model natural intelligences very well, as it requires 2 things which are not naturally occurring. The first is that

I think the most intuitive intelligence is social intelligence. Think of ground-hogs, going about their day, trying to get food to eat, and avoid predators. If they

1. Global (or at least regional) cost function
1. Cannot have A priori knowledge of what the cost function is
1. Communication between individuals is extremely limited compared to computation within an individual

These are the only basic constraints of the model. If we can meet these constraints, and have intelligent behavior, then I think we have made significant progress at modeling social intelligence.

### Diving into requirements

Unfortunately, when you start thinking about how to tie traditional machine learning models with these constraints, there are problems pop up immediately.

#### Global/regional cost function and no "a priori" knowledge

Problems:

1. The most powerful machine learning tools, like gradient descent, depend on cost being available at the node level. So we need to use weaker techniques or somehow turn a global cost into local ones.

Potential side benefits:

1. Global/regional cost is easy to reason about in complex simulations, so it will be an easy parameter to give to the learner.

#### Limited communication

1. Must use information about the state of other nodes/animals in the system in order for intelligence to emerge, but it is not clear what sorts of state should be revealed to other individuals (another complex hyperparameter to tune).
1. Cannot use 3+ layer neural networks with backpropagation for our social intelligence (since this involves passing the full input-hidden matrix around between individuals, which is unreasonable).
1. 2 layer network are fine, but are not very powerful.

Potential side benefits:

1. Limited information sharing will allow the algorithm to scale to thousands of machines easily (cutting edge neural networks usually don't get much beyond 100 machines).

### Solution

My proposed solution is [on this post](exploration_intelligence/generalized_intelligence_model), but any learner with these requirements and that learns well should be able to meet the goals of my project, and make great strides into understanding the natural intelligences.

So try to come up with something yourself!
