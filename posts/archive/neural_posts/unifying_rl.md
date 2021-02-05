---
title: Unifying Exploration and Exploitation In Reinforcement Learning
under_construction: true
excerpt: "Paper explaining reinforcement learning exploration as information maximization problem."
comments: false
share: false
---

The difficulty with reinforcement learning is often framed as exploration vs exploitation.

With the discovery of the policy gradient, and effective real world methods that use policy gradient, such as PPO or SAC, exploitation is thought to be more or less solved.

Exploration also has convincing theoretical and practical algorithms, such as action entropy regularization (SAC) and count based exploration (Bellemare 2016).

However, balancing exploration and exploitation is still very difficult. Balancing exploration and exploitation still requires environment specific hyperparameter tuning, and carefully design of systems using secret sauces that few organizations have mastered or even understand.

I propose that reinforcement learning is a single multi-term information maximization problem that incorporates both exploration and exploitation, hopefully making the tradeoffs easier to understand and balance without significant hyperparameter tuning.

### The optimality variable

Perhaps the most significant contribution of this paper is the introduction of the optimality random variable. This will be the key to discussing reward maximization as an information problem, which is the key to unifying exploration and exploitation.

The optimality variable $$O$$ is a binary variable sampled from the following marginal distribution:

$$P(O=1) =\left( \sum_\tau \exp\left(\sum_{t=0}^{t_\tau} R_t \right)\right)^{-1}$$

And joint distribution:

$$P(O=1|\tau) = P(O=1) \exp\left(\sum_{t=0}^{t_\tau} R_t \right)$$

Intuitively, this random variable $$O$$ is the probability of the trajectory being "optimal". The idea is that the rewards are a noisy signal that the trajectory is optimal, and this random variable signifies the true optimal trajectory. What we are maximizing with the mutual information is the overlap between the trajectories the policy visits and the optimal trajectory. Therefore, we are making our trajectories more optimal, and thus receive more reward as we maximize information.

### Proof

$$\begin{aligned}
\max_\theta \text{MutualInfo}(\tau_\theta, O) &= \E_{\tau_\theta, O} \left[ \log \left(\frac{P(\tau_\theta, O)}{P(\tau_\theta)P(O)}\right) \right] \\
 &= \E_{\tau_\theta, O} \left[ \log \left(\frac{P(O|\tau_\theta)P(\tau_\theta)}{P(\tau_\theta)P(O)}\right) \right] \\
 &= \E_{\tau_\theta, O} \left[ \log \left(\frac{P(O|\tau_\theta)}{P(O)}\right) \right] \\
 &= \E_{\tau_\theta, O} \left[ \log \left(P(O|\tau_\theta)\right) - \log(P(O)) \right] \\
 & \ \ \text{Applying linearity of expectation} \\
 &= \E_{\tau_\theta,O} \left[ \log \left(P(O|\tau_\theta)\right) \right] - \E_{\tau_\theta,O}[\log(P(O))] \\
 &= \tfrac{1}{2}(\E_{\tau_\theta} [ \log (P(O=1|\tau_\theta))] + \E_{\tau_\theta} [ \log (P(O=0|\tau_\theta))]) - \E_{\tau_\theta,O}[\log(P(O))] \\
 &= \tfrac{1}{2}(\E_{\tau_\theta} [ \log(P(O=1)\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )] + \E_{\tau_\theta} [ \log (1-P(O=1)\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )]) - \E_{\tau_\theta,O}[\log(P(O))] \\
  \end{aligned}
  $$
  Assuming number of possible trajectories (not those the policy takes, but all trajectories) with significant reward is large, $P(O=1)$ will be very small compared to $\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right)$ so we can approximate:
  $$\begin{aligned}
 &\approx \tfrac{1}{2}(\E_{\tau_\theta} [ \log(P(O=1)\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )] + \E_{\tau_\theta} [ \log (1-0 )]) - \E_{\tau_\theta,O}[\log(P(O))] \\
  &= \tfrac{1}{2}(\E_{\tau_\theta} [ \log(P(O=1)\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )] - \E_{\tau_\theta,O}[\log(P(O))] \\
  &= \tfrac{1}{2}\E_{\tau_\theta} [ \log(P(O=1))] + \tfrac{1}{2}\E_{\tau_\theta} [ \log(\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )] - \E_{\tau_\theta,O}[\log(P(O))] \\
  &= \tfrac{1}{2}\E_{\tau_\theta} [ \log(P(O=1))] + \tfrac{1}{2}\E_{\tau_\theta} [ \log(\exp\left(\Sigma_{t=0}^{t_\tau} R_t \right) )] - \tfrac{1}{2}\E_{\tau_\theta}[\log(P(O=1))] -  \tfrac{1}{2}\E_{\tau_\theta}[\log(P(O=0))]\\
  &= \tfrac{1}{2}\E_{\tau_\theta} [\Sigma_{t=0}^{t_\tau} R_t ] -   \tfrac{1}{2}\E_{\tau_\theta}[\log(P(O=0))]\\  \end{aligned}
$$

So what are the two remaining terms after the approximation?

The second term
$$\tfrac{1}{2}\E_{\tau_\theta}[\log(P(O=0))]$$
will be very close to 0 if the number of states with high reward is large.



That just leaves the first term:
$$\tfrac{1}{2}\E_{\tau_\theta} [\Sigma_{t=0}^{t_\tau} R_t ] $$
Which is just the standard RL policy objective!

Note that the above proof clearly generalizes the discounted value objective:
$$J(\theta) = \E_{S \sim \pi_\theta} \left[ \sum_{t=0}^{t} \gamma^t R_t \right] $$

### Advantage as mutual information

Theorem: Where $$O$$ is the optimality variable, $$S$$ is an environment state, $$a$$ is an action, and $$A$$ is the advantage function, then

$$P(O=1|a,S,\theta) = A_\theta(S,a)$$

So using the fact that P(O=0) is low under almost any condition,  similarly to the above argument, we can say

$$\max_\theta MI(O,(a,S_\theta)) = A(S)



#
