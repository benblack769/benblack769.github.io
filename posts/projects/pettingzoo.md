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



PettingZoo makes deep multi-agent reinforcement learning accessible to the common person by defining a powerful environment API allowing for reusable code. Its ambition is to have an equivalent role as [OpenAI Gym](https://gym.openai.com/) in the multi-agent RL space.

* Code at: [https://github.com/PettingZoo-Team/PettingZoo](https://github.com/PettingZoo-Team/PettingZoo)
* The website and documentation is at [pettingzoo.ml](https://www.pettingzoo.ml/)
* Technical paper is at: [arxiv](https://arxiv.org/abs/2009.14471)
* Tutorial at [towards data science](https://towardsdatascience.com/multi-agent-deep-reinforcement-learning-in-15-lines-of-code-using-pettingzoo-e0b963c0820b)

My contributions include:

* Influencing API design decisions, including the addition of the `last()` method, the `agent_iter()` method (see [paper](https://arxiv.org/abs/2009.14471) for details), and the inclusion of the [parallel API](https://www.pettingzoo.ml/api).
* Implementing support for and writing documentation for [MAgent](https://www.pettingzoo.ml/magent), [MPE](https://www.pettingzoo.ml/mpe), [Atari](https://www.pettingzoo.ml/atari), and [Chess](https://www.pettingzoo.ml/classic/chess).
* Writing frontend code to implement [website](https://www.pettingzoo.ml/) design, including code to automatically generate gifs and AEC diagrams.
* General Maintenance, including responding to and fixing issues, maintaining environment versions.
* Rewriting and refactoring tests, maintaining CI testing.
* Writing [developer documentation](https://www.pettingzoo.ml/dev_docs)
* Helping write [the academic paper](https://arxiv.org/abs/2009.14471)

Here is a poster we showed at the NeurIPS Deep Reinforcement Learning workshop:

![Poster advert](/images/pettingzoo/Neurips_DRL_poster.svg)
