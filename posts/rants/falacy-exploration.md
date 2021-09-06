---
title: Fallacy of exploration
under_construction: false
excerpt: "The notion of exploration in reinforcement learning is based off a false notion that we are alone in the world. We are not alone, we did not come from nothing, and if we want reinforcement learning to be successful, we must understand that basic fact."
comments: false
share: false
post_date: "2019"
---

What is the nature of exploration?

When you want to explore a task, what do you try? What do you glance at? How does this behavior differ from when you are doing a job you are very familiar with?

Well, lets start with what you don't do:

1. You don't randomly flail around hoping you will stumble into some situation you do know how to handle (are you an infant, or a thinking adult?)
1. You don't love spending time looking at unfamiliar things (are you here to sight see? Get to work!)

Sadly, these are the two basic foundations of exploration in modern deep reinforcement learning.

### The super-ego of RL research

Why did reinforcement learning come to such absurd conclusions that are so different from our ideas in real life?

Well, unlike in real life, reinforcement learning agents are all on their own. No supervision, no do-overs, no self-motivation, no intrinsic or learned ideas of right or wrong, or how the world works. So everything must be stated in the absolute most basic terms: try to find your way in a world you don't have any idea about, and be told if you did good or bad.

What an awful life! If you don't know anything about the world, what else can you do but randomly flail in despair and pray for the best? If you don't know what is good or bad, what else can you do but look forward to things which are at least different?

That this life seems so awful raises a higher level question: Why are RL researchers trying to develop algorithms that work in such a harsh world?

While lets look at some of the influential literature. AlphaGo beat world champion go player Lee Sedol with supervision from hundreds of thousands of human games. What logically comes next, but AlphaZero, an algorithm which does even better but learns from 0 human games! How much more amazing is that! Be a god-like go player (professional go players talk about the divine play of AlphaGo), with no extensive training in the game, just a few thousand lines of code built upon standard tools. This feat captured the imagination of the AI community for years.

Another huge project was AlphaStar, a grandmaster level Starcraft AI which beat professional players in matches. This was trained on 900,000 human games. The obvious thought is, what if you could make an AlphaStarZero algorithm that could be trained without these human games? Then perhaps this sort of AI could be developed for new games. How amazing would that be! Have a game released with a god-tier AI built in to play with.

These successes and promises have captured the imagination of more practical minds as well. Robotics labs across the country are racing to get these sort of successes working for robotics in the real world. How amazing would it be just to tell a robot what worked and what didn't and for it to learn all the physical dynamics of how to do the task?

In a way, this is reflective of the desire to able to solve any problem where success can be easily described. Unfortunately, since $$P \ne NP$$ we know this cannot be done efficiently, even in strait forward cases. This basic efficiency problem helps explain why reinforcement learning is rarely used in real world robotics, and even in those rare cases, it is only used for minor fine tuning of certain movements and dynamics that are already well engineered.


### The role of teaching

Perhaps the solution to this problem of exploration is simple. Don't be so lazy! Maybe if we did a little more work to help the agent out in its new environment, it would not have to flail in despair so much, and could search around in a more directed manner.

First, curriculum learning. This idea from pediatric education is non-trivial to implement in rl, but it has interesting potential. Instead of just describing the end task we want our agent to eventually solve, maybe we should construct a curriculum of tasks, the first task should be very easy, and each successive task should be more difficult than the last. The hope is that the agent will easily learn the easier tasks, and then be able to understand the world better, and have a better idea of how to move towards solving more difficult tasks.

Second, subtask decomposition, an education idea from animal training. Perhaps a complex movement with different stages can be broken down into a series of rewards, where you are rewarded a small amount for completing the first few steps, and then a large amount when you complete the whole thing. After awhile some of the steps become trivial to accomplish, and hopefully the agent has learned enough about the world to start to solve the harder steps.

Third, self-play. Playing with an agent with a similar level of intelligence is a great way to train, as the level of play increases naturally as learning progresses, creating a perfect learning curriculum. What is the goal of this play? Not clear, but perhaps almost any goal will work. As long as the task is competitive, open-ended, and balanced, learning about the world will be rewarded by winning more often.

### The role of learning

Unfortunately, all this good teaching methods will only get you so far. The agent actually needs to be able to learn from your lessons, by synthesizing and abstracting lessons, remembering the ideas and skills developed in previous lessons and transfer them to solving the actual task of interest to you. For non-trivial tasks, this is no easy feat, almost certainly beyond the capabilities of multi-layer perceptions we depend on currently. But, this question of how one can learn will not be the main focus as long as rl research is still stuck on this absurd notion of exploration.
