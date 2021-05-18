---
title: "PettingZoo"
slug: pettingzoo
under_construction: false
excerpt: "Gym for Multi-Agent RL. 500+ github stars, 93 resolved issues."
website: "https://www.pettingzoo.ml/"
publication: "https://arxiv.org/abs/2009.14471"
code: "https://github.com/PettingZoo-Team/PettingZoo"
comments: false
share: false
post_date: "2020-2021"
priority: 2
img: /images/pettingzoo/PettingZoo.svg
---

### Motivation

Some of the most well known and inspiring advances in AI since the deep learning revolution has been in Deep Reinforcement Learning (DRL). Successes like [Deepmind's vivid learning of breakout](https://www.youtube.com/watch?v=TmPfTpjtdgg) and [AlphaGo defeating world champion Go player Lee Sedol](https://deepmind.com/alphago-korea) transformed the common understanding of what is possible to accomplish with computers, and helped drive the current deep learning revolution.

Recognizing the importance of DRL, OpenAI started an ambitious project to make DRL easily accessible to everyone. They designed [gym](https://gym.openai.com/), a standard library and API that focused on making environments easy to swap out, encouraging interchangable RL code, and successfully making RL approachable to students and non-specialists, and also successfully made reaserch and software development much easier for the specialized RL community.

Multi-agent reinforcement learning has gained massive popularity in recent years, with hundreds of papers being published in the area every year. Multi-agent tasks are important to the reinforcement learning community because cooperation and competition offer interesting challenges without having to increase the complexity of the environment. Reinforcment learning is also extremely exciting to the Multi-agent systems community, as they wish to study interactions between intelligent agents, and RL offers an automatic way for agents to gain intelligent behavior. However, the study of multi-agent reinforcement learning is much less accessible to students and non-specialists, and reaserch and software development is much harder than ordinary reinforcement learning. We suspected this was due to the lack of a standard multi-agent API like Gym.

### Overview

PettingZoo defines a powerful environment API which allows for reusable code for different types of environments. Its ambition is to have an equivalent role as [OpenAI Gym](https://gym.openai.com/) in the multi-agent RL space. We made a number of unusual additions to our system to make it accessible to beginners in the field, such as extensive documentation, tutorials with popular RL learning frameworks, and more.

* Code at: [https://github.com/PettingZoo-Team/PettingZoo](https://github.com/PettingZoo-Team/PettingZoo)
* The website and documentation is at [pettingzoo.ml](https://www.pettingzoo.ml/)
* Technical paper is at: [arxiv](https://arxiv.org/abs/2009.14471)
* Tutorial at [towards data science](https://towardsdatascience.com/multi-agent-deep-reinforcement-learning-in-15-lines-of-code-using-pettingzoo-e0b963c0820b)

### My contributions

* Influencing API design decisions, including the addition of the `last()` method, the `agent_iter()` method (see [paper](https://arxiv.org/abs/2009.14471) for details), and the inclusion of the [parallel API](https://www.pettingzoo.ml/api).
* Implementing support for and writing documentation for [MAgent](https://www.pettingzoo.ml/magent), [MPE](https://www.pettingzoo.ml/mpe), [Atari](https://www.pettingzoo.ml/atari), and [Chess](https://www.pettingzoo.ml/classic/chess).
* Writing frontend code to implement [website](https://www.pettingzoo.ml/) design, including code to automatically generate gifs and AEC diagrams.
* General Maintenance, including responding to and fixing issues, maintaining environment versions.
* Rewriting and refactoring tests, maintaining CI testing.
* Writing [developer documentation](https://www.pettingzoo.ml/dev_docs)
* Helping write [the academic paper](https://arxiv.org/abs/2009.14471)

### Advert

Here is a poster we showed at the NeurIPS Deep Reinforcement Learning workshop:

![Poster advert](/images/pettingzoo/Neurips_DRL_poster.svg)
