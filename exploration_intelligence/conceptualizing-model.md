## Generalized Model of Intelligence

### Preface

This model is supposed to meet the requirement set out in [this page](exploration_intelligence/generalized_intelligence_requirements), while learning reasonably quickly. So glance over those if you haven't already.

The approach described is deeply and subtly inspired by neural networks, and I will reference the terminology. Before continuing, I suggest reading an introduction to basics like backpropagation and gradient descent, how deeper learning works better than shallow learning etc. Much of this will be covered in my introduction to Neural Networks on my site eventually.

### Introduction

While there are current techniques that could maybe be used to solve this problem to some degree, I wanted to try to explore this for myself, so that I could get a more intuitive understanding of the subject. In particular, I wanted to gain a deeper understanding of learning problems like long term memory and meta-intelligence, which I hope to solve one day.

### Intuition approach: Self-analysis

talk about how it is always a good idea in AI (especially modeling intelligence) to figure out how you reason about a problem.

In AI development, it is almost always a good idea to look at how humans solve the problem. Often, including the case at hand, humans perform far better than any computer, and so understanding how humans solve the problem hints at how computers should solve the problem. I believe that humans were a deep inspiration for AlphaGo. Even when computers do better than humans, this analysis can still be useful to improve the AI. Take Chess, where the AI beat humans back in the 90s because it can check more branches of the game tree. But humans were still better at large scale strategy, and human-computer teams can still easily beat computers. So a lot of current research in chess AI is trying to figure out what humans are doing and copying that.

So what I will be doing to figure out how to implement general intelligence is looking at what I do as an intelligent being, isolate the important mechanics from the noise, and then reconstruct similar mechanics efficiently with computer code.

talk about how I thought of my how my own ideas formed, how I learned, etc. Talk about how I noticed headaches caused by continued muscle extension caused by overexertion, emotional change causing emotional exhaustion rather than the emotions themselves.

How do thoughts form? This is a huge question that is almost certainly impossible to answer completely without advanced technology. None the less, I have been asking myself this question for years. And I found is that *there is a physical, tangible, change in my body when complicated thoughts form.* Usually this involves muscles in the head moving around, although there are often more obvious changes, such as bobbing heads when listening to music, fidgeting when doing math, etc.

After I noticed this, I

talk about how thoughts "travel backwards", linking memories back in time.



Mention how this is very difficult to formalize. make sure to link the ideas laid out here in the constructions in the later part of the post.

### Formal approach

#### Abstracting state

talk about how internal state is the only state we can consider (because we don't know exactly how external state affects internal state, only that it does).

talk about how we need a way to group external states into higher level states (and how this is absolutely key to high level intelligence, and possibly mention that that is what multilayer NNs try to accomplish). Example: standing up is a hugely complex state, we need to abstract it to a single state, or a small number of states. talk about how we shouldn't really know which states are higher level consolidations and which ones are original states.

talk about how states, outputs, and costs need to be as continuous as possible (to maximize learning opportunities).

#### Localizing and backpropogating cost

talk about need to estimate local cost from global cost (is not known, so we need to use function estimation). Maybe bring in papers about this, since this is really hard.

talk about how in order to predict costs in simulation (see below section), we need to figure out which states cause/correlate with costs. In this way, we want costs to consolidate, i.e., we want higher level states that strongly correlate with cost.

talk about how in order to optimize cost (see below section), we need to avoid activating states that strongly correlate with costs. Note that this conflicts with the above analysis. Need to figure out how to resolve this contradiction.

#### Taylor expansion of intelligence

Talk about estimating:

Simulation intelligence: (needed to construct scenarios you haven't encountered)
Cost ~= f(internal state)

Optimizing intelligence: (meets basic intelligence requirements)
Change Cost ~= f(change in internal state)

Meta-intelligence:
Change in Change in Cost ~= f(change in change in internal state)



### Structure of the model

Diagram pointing things out like the inputs and how they take in different senses, the outputs, and how they represent different actions. Linear learner model.

### Dynamics of the model

This is the hard part:

#### Intuitive approach

Talk about special input and output, where the input is the magnitude of a variable following a tanh path, and the output is how much that variable should change in the next timestep. Perhaps forcing towards zero is a good stabilizer.

#### Formalizing dynamics
