
In end to end supervised learning trained with backpropogation, memory must be explicitly differentiable to meet [the definition of memory](/#memory).

However, in reinforcement learning, this is not necessary. All you need is a sufficiently expressive environment so that you can encode information into the environment in a way that is easy to observe. For example, writing it down on paper. Why? Because the value function provides implicit backpropogation.

$$ Q(S, a) \sim= r + V(S^\prime) $$

and

$$V(S^\prime) \sim= r + V(S^{\prime\prime})$$

Where $$\sim=$$ means updated to be closer to.

(we assume that the relevant part of the state is fully observable, as it would be in the case of memory as state)

So you can see that if the future states after the action do more poorly due to the memory stored, then after a few iterations, the state will have less value.

If $$r + V(S^\prime)$$ evaluates worse than $$Q(S, a)$$ then $$Q(S, a)$$ will know that $$a$$ did a bad job storing the memory, so it will have a gradient of $$a$$ vs the change in value of the state.

So you have memory updating to be more useful. The only problem is that this is a very difficult credit assignment problem. So [perhaps there can be a reward that explicitly encourages information to be remembered this way](/#clock_information_exploration).
