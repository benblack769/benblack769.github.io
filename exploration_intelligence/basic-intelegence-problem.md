---
title: Intelligence as a Definable Problem
under_construction: false
slug: basic-intelegence-problem
excerpt: "Philosophical inquiry into the nature of intelligence."
---

# Formalizing Intelligence

What is intelligence? Why is the student who answered the professor's hard impromptu question smart? What makes a beehive smarter than an individual bee? Why do we appreciate child geniuses more than adults who are just as capable?

This question, more in the field of metaphysics than science, is a question I have asked myself for years. After all, I really like being seen as smart, and if I can answer that question, then I can focus my efforts to make myself smarter.

But recently, I have been thinking the same question in a different context, that of machine intelligence. Why do some people think some applications are smart? Why do more experienced programmers and computer scientists take a more skeptical view of the intelligence of computers than most people? And finally, what can I do to make my code act truly intelligently?

I had my first insight in a Philosophy of Computation class. We read several papers by skeptics of AI. And in particular, one piqued my interest: "Psychologism and Behaviorism", by Ned Block, Section 2 ( [link](http://www.nyu.edu/gsas/dept/philo/faculty/block/papers/Psychologism.htm)). Block describes a hypothetical machine that a human programs to respond to every possible set of questions within a fixed amount of time with an appropriate answer. This is not physically possible in our universe for long time periods. But in theory this machine passes the Turing test even though it somehow doesn't seem intelligent. Rather the human programming it is the intelligent one. To, that begs the question: what about this machine makes it unintelligent? I tried to resolve this problem myself. And what I discovered is that intelligence is simply making good decisions quickly with limited information. Maybe obvious in hindsight, but stating it clearly has advantages.


### Precise philosophical framework

If you don't like to read definitions, feel free to skip to the next part.

Definitions:

The intelligent actor: A being that can affect its environment. It has desires that it wants satisfied.

The world: The place where the intelligent actor makes decisions in, i.e., it can make some limited changes to this world, and the world will have some effect on the intelligent actor's desires. Anything which cannot affect the actor, or that the actor cannot affect is not inside the world.

Inside this world, intelligence is a relative property that scales negatively with both time and information. The way in which it scales is contextual, depending on the scarcity of information or time in this world.

Hopefully, you can see how this definition can apply to both traditional human contexts, like evaluating students' growth and also in traditional machine contexts, like comparing optimization algorithms.

### Circumstantial evidence

If you are already convinced by my thesis, feel free to skip to the next section.

I collected several stories to support this reasoning.

First, why do we see younger people accomplishing tasks as more amazing than older people? For example, lets say we have an undergraduate math major, and a math professor. They look at a math problem, and solve it in roughly the same time. Why do we tend to see the college student as smarter in this scenario? Especially when the physical brain of the college professor is probably in worse shape? It seems to be because we expect the college professor to know more, have more experience, etc, and thus be able to solve the problem faster.

Second, why do experienced programmers have a dimmer view of machine intelligence than  average people? This is a pattern I have seen myself over and over:

A smart person sees a technology like Siri, which pretend to be intelligent, or a traditional AI for a game like chess. They get really excited, and think that it is amazing and brilliant. They dig into AI, learn to code, start reading papers, etc, to learn how it works. Then they start to realize that it is actually not that intelligent--rather, a lot of smart programmers and computer scientists built a carefully crafted mechanism which gets the very specific task at hand done.

What do they learn that makes them so skeptical?

For traditional AI, it seems to be the programming. People quickly realize that everything they thought was intelligent was a simple reaction carefully chosen by the programmer.

This reaction is powerful and ubiquitous across programmers. It fuels deeply skeptical arguments against AI like the Chinese room thought experiment.

In this case, the data that the program consumes is the code itself. So to a programmer, we just see a text that someone wrote, and a simple universal Turing Machine that is faithfully executing the script. For more complex programs, what people discovered is that the text needs to get astronomically big. This approach that everyone thinks is unintelligent requires astronomically more data than we can imagine.

For modern AI, like Google's AlphaGo, the perception of intelligence tends to stick around a little longer. It is more convincing, even to knowledgeable people. Part of this is that neural networks are famously hard to reason about, and so even reasonably informed people still can be in ignorant bliss of how it actually works. Part of it is that NNs are legitimately able to handle more complex problems.

But others, including myself, eventually loose their perception of neural network's intelligence. This seems to be caused by two things:

1. The model lacks generality to work in anything remotely approaching the real world.
2. The model requires ridiculous volumes of data, far more than it would take a human to learn the same thing.

Note that these two things are a famous tradeoff in all AI, and you can be assured that one or the other will hold until we actually get strong AI.

The second one is what I see as evidence for my thesis, that intelligence is about acting quickly with limited data.

### So what?

What does all this mean? Why do we care what intelligence is?

As a AI enthusiast, I think it is vital to creating low level representations of intelligence. Simply understanding that an intelligent behavior defined by is acting with limited data has helped me focus my study of AI. It provides an easy way to eliminate strategies which seem neat, but clearly won't work well generally because they require too much data.

I also think that this perspective offers insight into the deep philosophical question: What is the purpose of emotions? In this framework, emotions are the cost function of the intelligence.

As a person who has always strived to be smarter, this insight into intelligence also provides a framework for understanding why some people seem smarter than others. After all, our brains work approximately the same. So why are some people more naturally talented than others? Most of it is just that some people learned the skills better and earlier, even if they didn't realize it.

But this doesn't seem to explain everything. I think that the rest of it is that people are emotionally inclined to certain skills. From a formalized learning perspective, this means that their cost function responds more rapidly and acutely to small deviations in performance, allowing faster learning. From a behavioral perspective, this means that one's emotions ride a roller-coaster based on how well they are doing at the moment--in other words, they love what they do....

### Next up!

Next up on this line of posts is a long philosophical rant about connectionism and how it applies to machine learning approaches.
