## Inspiration

### Guard thief game

The guard thief game is when the guard is trying to locate the thief, but does not know where the thief has traveled, and the thief is trying to find some objects in the space, but does know where those objects are. When the guard finds the thief, the game is over. In real life, the game might transition to a pursuit-evasion game, but here the game simply ends for simplicity.

Here is an example: the guard is green, the thief is blue, and the points to steal are red. The yellow is the path the thief is currently trying to follow.

<video class="loop_video" controls muted width="250">
    <source src="/images/robo_proj/dynamic_house_vid.mp4"
            type="video/mp4">
    Sorry, your browser doesn't support embedded videos.
</video>

Note that since the agent's sight radius is greater the the guard, it can successfully avoid the guard a significant proportion of the time.

### No information guard-thief game

But what if the guard had a greater radius of sight than the thief. In this case, since the game ends as soon as the guard sees the thief, and since sight is symmetric, the guard and thief will never see each other for the duration of the game!

This makes for some interesting game theory as I will talk about.



### Solving the game

This no information game can be modeled as a simultaneous game where each player picks a path at the start of the game, and then follows this path until the guard sees the thief, or the game ends.

## David Balduzzi

### Building a solution by adding agents to a population

The idea is that instead of a single strategy, we will have many potential strategies that can be probabilistically selected from to form a final solution.

#### Population evaluation

Given populations $$B$$, $$G$$, payoff matrix $$A_{uv}$$, and probability matrices $p$, $q$, the evaluation is just

$$p A q$$

#### Optimize this population

The goal is to optimize the population payoff. This can be accomplished in two ways. First, you can strengthen each agent separately, by for example, self-play. But sometimes the best response against one agent means a worse response against some other agent.

So first, you need a diverse population of agents which will allow you to

#### Population diversity

Intuition: T

Given population $$B$$, payoff matrix $$A$$, nash support $$p$$,



you get the rectified



## Extensions to other settings

### applying to non-antisymmetric zero sum games

The theory might not be as nice, but in practice, the same ideas should work, just need to keep track of two populations.

The one problem is that the idea of "losing" is not well defined in a non-antisymmetric zero-sum game. But perhaps a seemingly crude heuristic like subtracting the outcomes by a mean outcome will work.

### Applying to symmetric 2d games

In robotics especially, symmetric games are perhaps more important than antisymmetric ones.

In a symmetric 2d game, there might also be mixed nash equilibria, for example the game

 x | A | B
 --- | --- | ---
 A | 0 | 1
 B | 1 | 0

Here, note that if the players could communicate, they would arbitrage which player should pick 1 and which player should pick 0, and they would be able to optimize their reward. If they can't then the mixed strategy where they pick one with equal chance is optimal.

In general, in symmetric games, there is always a globally optimal pure strategy if you allow for communication. However, finding this pure strategy will in general be computationally impossible.

On the other hand, if you don't allow for communication, then there may be an enormous number of local Nash equilibria that are suboptimal. This is clear because of the large number of different strategies people arrive at when working together. This inspires the idea of exploring the space by matching and mismatching strategies in a similar way to the rectified Nash response above.

Note that if you apply the rectified Nash directly, there are two issues to resolve, first, that every reward will be positive in general, so the idea of "losing" or "winning" to a strategy needs to be redefined. A first pass idea is to have winning as doing better than 80% of strategies, or some other value.

Second is that there may be many Nash in the matrix, this can be solved by splitting the evaluation matrix into many matrices each of which has a unique nash. Note that since the evaluation is symmetric, a single strategy cannot have support under two different Nash (proof evades me for now).

#### Making robust strategies

Note that at if you want to start consolidating policies into a single, robust policy, you can switch direction from expanding the nash to consolidation and start training a single policy against all of its weaknesses.

This would be a good idea if you want to collaborate with humans, as you will have to deal with all kinds of poor behavior.

#### Smoothing the nash support

If instead you want an optimal policy rather than a robust one, you want a more steady consolidation process that encourages both policy growth and consolidation, then you can start smoothing the nash support.

Note that in this setting, finding a Nash is equivalent to finding a local optimum of

$$\max_p p^T A p $$

You can final local optimum with gradient descent based methods.

Note that to find a nash which supports a particular strategy $$i$$, then you can just start this gradient descent with a vector with a high value of $$p_i$$ and a low value of every other strategy. This will work because it is a quadratic system.

So to smooth the nash support, you can just penalized high probabilities.

$$\max_p p^T A p - \lambda \|p\|^2$$

And of course, increase lambda to smooth things out even more. Note that this smoothing will eventually make more and more strategies be dominated, as strategies are forced to work with more diverse strategies, so you probably want to be removing dominated strategies as well as this process.

## Approximating the algorithms

There are two difficulties with using these methods,

1. Approximating the Nash equilibria with noisy (and possibly sparse samples) in a way that does not ruin the beautiful theory. Quite difficult with more than two players.
2. These algorithms assume you can find a global optimal response to the current mixture. This is of course, impractical, gradient methods in complex spaces need a decent prior (which could be biased towards certain solutions) and can only find local optimum relative to that prior in its parameter space.

### Simple Test Environments

Some really simple games you can find the global optimal response via brute force. You can test the approximation methods vs their optimal form with this method.

Colonel blotto * matching game

RPC * matching game



### Complex test environments

These solutions can be compared to other state of the art solutions on multiplayer games.

- Active thief game
- PettingZoo games for good cases...

### Policy selector game

A Environment is dominated by another if its expected value (according to its playout) is strictly lower or strictly higher than the other on every single policy.

A policy is dominated by another if its actual value (according to its playout) is lower than another's for every single environment.

Of course, we can't know all of these things, but
