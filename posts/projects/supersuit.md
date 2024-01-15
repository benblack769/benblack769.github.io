---
title: "SuperSuit"
slug: supersuit
under_construction: false
excerpt: "General environment transformation wrappers for PettingZoo and Gym. (100+ github stars)"
code: "https://github.com/Farama-Foundation/SuperSuit"
comments: false
share: false
post_date: "2020"
priority: 0
img: /images/pettingzoo/SuperSuit_Icon.png
---


[SuperSuit](https://github.com/Farama-Foundation/SuperSuit) makes common environment preprocessing very easy to use for [OpenAI Gym](https://gym.openai.com/) and [PettingZoo](https://pettingzoo.farama.org/) environments. Interesting use cases include applying the [large set of wrappers](https://pettingzoo.farama.org/atari#preprocessing) needed for learning Atari to both Gym and PettingZoo Atari environments without any code changes. This library has been popular with users new to RL and has been an essential tool internally to the PettingZoo team.

My contribution involved taking a poorly designed god-class for observation transformation, and turn it into its current modular form, implementing all the necessary code, tests, and helping write documentation.

I also designed and implemented the vector environment transformation in SuperSuit [documented here](https://github.com/Farama-Foundation/SuperSuit/#parallel-environment-vectorization) which allows multi-agent environments to be trained with [Stable Baselines](https://stable-baselines3.readthedocs.io/en/master/), a simple and popular RL framework. This trick (and other supersuit wrappers) powers the popular towards data science [PettingZoo tutorial](https://towardsdatascience.com/multi-agent-deep-reinforcement-learning-in-15-lines-of-code-using-pettingzoo-e0b963c0820b). The code for this article is shown below:


```python
from stable_baselines3 import PPO
from pettingzoo.butterfly import pistonball_v4
import supersuit as ss

env = pistonball_v4.parallel_env(n_pistons=20, local_ratio=0, time_penalty=-0.1, continuous=True, random_drop=True, random_rotate=True, ball_mass=0.75, ball_friction=0.3, ball_elasticity=1.5, max_cycles=125)
# basic usage of supersuit. Transforms observation of environment
# to make it fit the requirements of stable baselines
# and make it easier to learn. See tutorial for more details
env = ss.color_reduction_v0(env, mode='B')
env = ss.resize_v0(env, x_size=84, y_size=84)
env = ss.frame_stack_v1(env, 3)
# multi-agent vectorization trick
env = ss.pettingzoo_env_to_vec_env_v0(env)
# multiprocessing
env = ss.concat_vec_envs_v0(env, 8, num_cpus=4, base_class='stable_baselines3')

model = PPO("CnnPolicy", env, verbose=3, gamma=0.99, n_steps=125, ent_coef=0.01, learning_rate=0.00025, vf_coef=0.5, max_grad_norm=0.5, gae_lambda=0.95, n_epochs=4, clip_range=0.2, clip_range_vf=1)
model.learn(total_timesteps=2000000)
model.save("policy")
```
