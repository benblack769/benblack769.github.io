---
title: "SuperSuit"
slug: supersuit
under_construction: false
excerpt: "General environment transformation wrappers for PettingZoo and Gym. (100+ github stars)"
code: "https://github.com/PettingZoo-Team/SuperSuit"
comments: false
share: false
post_date: "2020"
priority: 1
img: /images/pettingzoo/SuperSuit_Icon.png
---


[SuperSuit](https://github.com/PettingZoo-Team/SuperSuit) makes common environment preprocessing very easy to use for [OpenAI Gym](https://gym.openai.com/) and [PettingZoo](https://www.pettingzoo.ml/) environments. Interesting use cases include applying the [large set of wrappers](https://www.pettingzoo.ml/atari#preprocessing) needed for learning Atari to both Gym and PettingZoo Atari environments without any code changes. This library has been popular with users new to RL and has been an essential tool internally to the PettingZoo team.

My contribution involved taking a poorly designed god-class for observation transformation, and turn it into its current modular form, implementing all the necessary code, tests, and helping write documentation.
