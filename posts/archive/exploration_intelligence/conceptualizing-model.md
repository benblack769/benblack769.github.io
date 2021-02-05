## Generalized Model of Intelligence

### Preface

This model is supposed to meet the requirement set out in [this page](exploration_intelligence/generalized_intelligence_requirements), while learning reasonably quickly. So glance over those if you haven't already.

The approach described is deeply and subtly inspired by neural networks, and I will reference the terminology. Before continuing, I suggest reading an introduction to basics like backpropagation and gradient descent, how deeper learning works better than shallow learning etc. Much of this will be covered in my introduction to Neural Networks on my site eventually.

### Introduction

While there are current techniques that could maybe be used to solve this problem to some degree, I wanted to try to explore this for myself, so that I could get a more intuitive understanding of the subject. In particular, I wanted to gain a deeper understanding of learning problems like long term memory and meta-intelligence, which I hope to solve one day.

### Intuition approach: Self-analysis

*talk about how it is always a good idea in AI (especially modeling intelligence) to figure out how you reason about a problem.*

In AI development, it is almost always a good idea to look at how humans solve the problem. Often, including the case at hand, humans perform far better than any computer, and so understanding how humans solve the problem hints at how computers should solve the problem. I believe that humans were a deep inspiration for AlphaGo. Even when computers do better than humans, this analysis can still be useful to improve the AI. Take Chess, where the AI beat humans back in the 90s because it can check more branches of the game tree. But humans were still better at large scale strategy, and human-computer teams can still easily beat computers. So a lot of current research in chess AI is trying to figure out what humans are doing and copying that.

So what I will be doing to figure out how to implement general intelligence is looking at what I do as an intelligent being, isolate the important mechanics from the noise, and then reconstruct similar mechanics efficiently with computer code.

*talk about how I thought of my how my own ideas formed, how I learned, etc. Talk about how I noticed headaches caused by continued muscle extension caused by overexertion, emotional change causing emotional exhaustion rather than the emotions themselves.*

How do thoughts form? This is a huge question that is almost certainly impossible to answer completely without futuristic technology. None the less, I have been asking myself this question for years. And I found is that *there is a physical, tangible, change in my body when complicated thoughts form.* Usually this involves muscles in the head moving around, although there are often more obvious changes, such as bobbing heads when listening to music, fidgeting when doing math, etc.

My insight: *human intelligence relies on sifting state to handle time series*. Wow, that statement was packed with all sorts of nonsense. Lets unpack it.

Shifting state: The inspiration here is music and dance. In good music, feelings are constantly moving around, introducing

Handling time series: Time data is one of the great difficulties of machine learning. In particular, what things to remember from the past is an unsolved problem. Even LSTMs and attentional networks, which are great attempts at introducing different kinds of state, do not handle large amounts of varying state particularly well. You can see some of my thoughts about LSTMs and how they handle time data [here](/neural_posts/neural_paper) (will update eventually to a more relevant paper). Both are very slow learners that struggle with longer time series. However, humans seem to be able to handle this problem amazingly well. We are extremely good at remembering the things that we think will be valuable to us later. We look at tons of things every day: signs, walls, floors. But we tend to remember the people we look at much better than any fo those things, despite not looking at them much more. This operates at a higher level too. One great example is advertisements, slogans, and mascots. These things engage our memory in ways that can easily dominate the interactions in our life. While this seems to be a degenerate example, it really isn't as it points to a interesting social nature of handling time series: we can often make other remember things we want them to remember, by showing emotion, by getting them excited.



What does this mean? It means that somehow, Basically, it means that in order for things to be intelligent, they need to be able to handle learning in an environment with state shifting around in reliable patterns. The innovation is that unlike most standard neural networks.

To give a more relatable example of this, take music. You can hum along some song that you know. If you start hearing it, you can pick it up, or if you hear elements of it

After I noticed this, I

*talk about how thoughts "travel backwards", linking memories back in time.*

Another idea is backpropagation of memories. When you run into an issue with life, i.e., a high cost is inflicted on you for some reason, you try to figure out how it worked. For example, you break up with your partner, the first thought is, what went wrong? When you don't know the answer, you go memories you think are relevant, and try to pick out signs of detachment. Then you go to earlier memories to try to figure out why that detachment occurred. And then earlier memories to see why those events occurred. And so you can see that we are really performing a very slow kind of backpropagation. I believe that backpropagation of some sort is essential for any sort of intelligence that follows my general model. The example in the setting of conscious thought is good though, because it suggests that there are different kinds that are not completely dependent on the mechanics of gradient descent.

*Mention how this is very difficult to formalize. make sure to link the ideas laid out here in the constructions in the later part of the post.*

This sort of intuition is extremely difficult to formalize. The following formalization work took me several years. There were times when I thought certain parts would be too difficult to figure out, and time when I almost gave up hope figuring out parts myself.

### Formal approach

#### Abstracting state

*talk about how internal state is the only state we can consider (because we don't know exactly how external state affects internal state, only that it does).*

State. What is this, what does it mean in the context of a machine. There are two different states we can consider. There is external state: the physical makeup of the world around the intelligence. This is things like you are sitting on a chair, there is a computer in front of you, etc. Then there is internal state: This is your mental state, what you are thinking at a given time (conscious), neurons firing in your brain (unconscious), and a person's thoughts about another (social). When formalizing intelligence, we can only consider internal state. Why? Because we cannot assume that we know how external state relates to internal state. We need to learn these things. We learn a computer is in front of us by the neurons in our eyes, people telling us that that things are computers when seeing these things, etc.

Internal state and external state sometimes seems ambiguous. Our arm is in front of us, not behind us. This seems like it is part of our conscious intelligence, as we probably cannot remember any time when this is not obvious. I mean, our arm is part of our body. How can we not know where it is? And honestly, for conscious intelligence, I am not quite sure. I am somewhat inclined to consider this internal. However, for unconscious intelligence, this is definitely external knowledge. All we see, as an unconscious intelligence, is that some neurons are firing. The values of some other neurons can cause a change in

*talk about how we need a way to group external states into higher level states (and how this is absolutely key to high level intelligence, and possibly mention that that is what multilayer NNs try to accomplish). Example: standing up is a hugely complex state, we need to abstract it to a single state, or a small number of states. talk about how we shouldn't really know which states are higher level consolidations and which ones are original states.*

*talk about how states, outputs, and costs need to be as continuous as possible (to maximize learning opportunities).*

#### Localizing and backpropogating cost

*talk about need to estimate local cost from global cost (is not known, so we need to use function estimation). Maybe bring in papers about this, since this is really hard.*

*talk about how in order to predict costs in simulation (see below section), we need to figure out which states cause/correlate with costs. In this way, we want costs to consolidate, i.e., we want higher level states that strongly correlate with cost.*

*talk about how in order to optimize cost (see below section), we need to avoid activating states that strongly correlate with costs. Note that this conflicts with the above analysis. Need to figure out how to resolve this contradiction.*

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
