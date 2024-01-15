---
title: "Multi-Agent Arcade Learning Environment"
slug: ma_ale
under_construction: false
excerpt: "A multi-agent extension to the Arcade Learning Environment"
code: "https://github.com/Farama-Foundation/Multi-Agent-ALE"
publication: "https://arxiv.org/pdf/2009.09341.pdf"
comments: false
share: false
post_date: "2020"
priority: 1
img: /images/pettingzoo/boxing.gif
---

The Multi-Agent Arcade Learning Environments are a multi-agent extension to the [Arcade Learning Environment](https://github.com/mgbellemare/Arcade-Learning-Environment), perhaps the most important environments in Reinforcement Learning.
The original environments were used to develop many of the innovations in Deep Reinforcement Learning (DRL), including the Deep Q Network (DQN), the first DRL algorithm.
We added multi-agent support to these environments out of the hope that these environments could prove a reliable testing ground for multi-agent algorithm development.

* Code at https://github.com/Farama-Foundation/Multi-Agent-ALE
* Publication on [arxiv](https://arxiv.org/pdf/2009.09341.pdf)
* A nice display of the environments is in the [pettingzoo documentation](https://pettingzoo.farama.org/atari).
* Code to train environments code [using RLLIB](https://github.com/justinkterry/MA-ALE-paper) and [using ALL](https://gist.github.com/benblack769/cbf4c0a674ad24d0e095263a0b553726).

The core code is written in C++ (written by myself). A low level python interface is included, and high level python interface and documentation is available through [PettingZoo](https://pettingzoo.farama.org/atari).

### Training efforts

We spent significant time attempting to learn effective policies in these environments via self-play. As discussed in the paper, our first attempt used agent indication and [RLLib](https://docs.ray.io/en/master/rllib.html) to train the environments (the bulk of the work was done by Luis Santos, I helped evaluate the trained models).  Below is one of the more successful examples (on boxing).

![boxing](/images/pettingzoo/boxing.gif)

RLlib posed various challenges and was unnecessarily complicated to work with, so we went and helped add multi-agent support to the [Autonomous Learning Library](https://github.com/cpnota/autonomous-learning-library), a well designed RL framework developed by Chris Nota. This resulted in much simpler, more reliable, and more scalable (for multiple experiments) code.

Some implementations using this multi-agent support for ALL are [here](https://gist.github.com/benblack769/cbf4c0a674ad24d0e095263a0b553726) and [here](https://gist.github.com/benblack769/400b42d54b6e57034da1e5293166aa80).
