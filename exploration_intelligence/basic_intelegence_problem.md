# Formalizing Intelligence

What is intelligence? What makes the smart person in the room seem smart? What makes a beehive seem smarter than an individual bee? Why do we appreciate child geniuses more than adults who are just as capable?

This question, more in the field of metaphysics than science, is a question I have asked myself for years. After all, I really like being seen as smart, and if I can answer that question, then I can focus my efforts to make myself smarter.

But recently, I have been thinking the same question in a different context, that of machine intelligence. Why do some people think some applications are smart? Why do more experienced programmers and computer scientists take a more skeptical view of the intelligence of computers than most people? And finally, what can I do to make my code act truly intelligently?

In line with the more philosophical nature of this question, I found my first real insight in a Philosophy of Computation class. In the papers we were reading, there were several skeptics of AI. And in particular, one piqued my interest: "Psychologism and Behaviorism", by Ned Block, Section 2 ( [link](http://www.nyu.edu/gsas/dept/philo/faculty/block/papers/Psychologism.htm)). There, he describes a hypothetical machine that a human programs to respond to every possible set of questions within a fixed amount of time with an appropriate answer. This machine acts intelligently enough to pass the Turing test, but it somehow doesn't seem intelligent. Rather the human programming it is the intelligent one. To, that begs the question: what about this machine makes it unintelligent? I tried to resolve this problem myself. And what I discovered is that intelligence is scales negatively with both decision making time and with amount of data known.

### Precise philosophical framework

If you don't like to read definitions, feel free to skip to the next part.

Definitions:

The intelligent actor: A being that can affect its environment. It has desires that it wants satisfied.

The world: The place where the intelligent actor makes decisions in, i.e., it can make some limited changes to this world, and the world will have some effect on the intelligent actor's desires. Anything which cannot affect the actor, or that the actor cannot affect is not inside the world.

Inside this world, intelligence is the degree to which


### Circumstantial evidence

If you are already convinced by my thesis, feel free to skip to the next section.

I collected several stories to support this reasoning.

First, why do we see younger people accomplishing tasks as more amazing than older people? In particular, lets say we have a college undergraduate math major, and a college math professor. They look at a math problem, go at it, and solve it in the same time. Why do we tend to see the college student as smarter in this scenario? Especially when the physical brain of the college professor is probably in worse shape? It seems to be because we expect the college professor to know more, have more experience, etc, and thus be able to solve the problem faster.

Second, why do experienced programmers seem too see computers as less intelligent than average people? This is a pattern I have seen myself over and over:

A person sees a technology like Siri, which pretend to be intelligent, or traditional AIs for games like chess. They get really excited, and think that it is an amazing thing. They dig into AI, learn to code, start reading papers, etc, to learn how it works. Then they start to realize that it is actually not that intelligent--rather, a lot of smart programmers and computer scientists built a fairly complex framework which gets the very specific task at hand done.

What do they learn that makes them so skeptical?

For traditional AI, it seems to be the programming. People realize that everything they thought was intelligent was simply a reaction coded by a person. This reaction seems to be why the Chinese room thought experiment is such a compelling argument.

For modern AI, like Google's AlphaGo, the perception of intelligence tends to stick around a little longer. It is more convincing, even to knowledgeable people. Part of this is that neural networks are famously hard to reason about, and so even reasonably informed people still can be in ignorant bliss of how it actually works. Part of it is that NNs are legitimately able to handle more complex problems.

But others, including myself, loose their perception of its intelligence. This seems to be caused by two things:

1. The model lacks generality to work in anything remotely approaching the real world.
2. The model requires ridiculous volumes of data, far more than it would take a human to learn the same thing.

Note that these two things are a famous tradeoff in all AI, and you can be assured that one or the other will hold until we actually get strong AI.

The second one is what I see as evidence for my thesis, that intelligence is about acting quickly with limited data.

### So what?

What does all this mean? Why do we care what intelligence is?

As a AI enthusiast, I think it is vital to creating low level representations of intelligence. Simply understanding that an intelligent behavior defined by is acting with limited data has helped me focus my study of AI. It provides an easy way to eliminate strategies which seem neat, but clearly won't work well generally because they require too much data.

I also think that this perspective offers insight into the deep philosophical question: What is the purpose of emotions? In this framework, emotions are the cost function of the intelligence.

As a person who has always strived to be smarter, this insight into intelligence also provides a framework for understanding why some people seem smarter than others. After all, our brains work approximately the same. So why are some people more naturally talented at things than others?




Of course
