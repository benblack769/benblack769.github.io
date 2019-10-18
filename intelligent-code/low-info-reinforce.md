
## Algorithm description

Idea is to learn a good projection of a complex state onto a medium dimensional vector space, and then use this vector space to aid exploration and the creation of meta-actions and objectives.

The good projection will be initialized using context-based unsupervised learning. Then the projections will be improved using the assumed objectives of the model and the reinforcement reward.

### Procedure 1: Rarefication

    do {
        vectors <- contextVsGlobal(states,time_scale)
        vector that are too similar to another vector are dropped (dropping a constant fraction)
    } while |vectors| > limit


Now, the states that are left are in theory more "rare" than states on average, i.e. their context is easier to distinguish from global contexts.

#### Proof of procedure 1

The "proof" requires several assumptions

1. `contextVsGlobal` maps different things (in the ideal semantic space) to sufficiently different vectors that the most similar *k* vectors to any vector are not too different (where *k* is much smaller than the number of similar vectors).
2. `contextVsGlobal` maps rare states (in the ideal semantic space) to random locations (i.e. it does not systematically place them too close to anything in particular).

Assumption 1 is probably a good one, at least when the number of dimensions of the vector space is small relative to the number of states. That is because assumption 1 is the most basic assumption in pretty much any unsupervised technique ever, which are getting pretty good.

Assumption 2 is a little more troublesome, as the function approximator can place rare states wherever it wants according to its objective. If this becomes a problem, perhaps concatenating a "differences of similars" vector, which should identify rare states most easily, or weighting bad similar calculations more strongly in the cost function could mitigate this to some degree.


Based off these two assumptions the proof can be done quite formally.


#### Implications of procedure 1

Once a space has been rarefied, and there is a function mapping states into groups with rare characterizing objects, there are a number of useful things we can do with this.

* Make a small reward for reaching the rare state (rewarding exploration)
*  Build a graph of how movement is possible between these states (giving a high level view of the transition function + current policy which may be more amenable to high level reinforcement learning).
* Predict future movement wrt. these states.
* Credit assignment wrt. these states.

Each of these are potentially huge. We will be incorporating 1, 3 and 4 for now, as we wish to remain in the realm of continuous algorithms.


### Procedure 2: Dependency generation

The problem with procedure 1 is that it is finding the easiest mapping to vectors that differentiate based off the state input encoding. This means that small changes in pixels in important places (say, a timer that counts down to game over) may be mapped to be similar, when they should be marked as different.

In other words, many truly rare items are not being found, and meaningless differences are being found. So we want the state vectors to respond to the reward, as we get it.

If the reward signal is extremely weak, we can use part 1 of procedure 1 to amplify it slightly. This makes no difference to the algorithm.

#### Procedure 2 algorithm description

Assume reward function is a single signal, the worst case for this procedure.

We will create a predictor for this reward, as well as the state that generates it as follows:

For an environment granted reward, `(state, reward)`, generate `(<prior projection of state>,<reward>)`.

Now, for a transition `(state, action)`, which leads to state `newstate` predict the following q-learning inspired idea:

    Expected_state_reward =
        <average projection of state of final reward>, <average final reward>
        ~= <predicted projection by newstate>,<predicted reward by newstate>

Now, once that learning procedure has been trained, you can use it to calculate the new contex vector

    context_vec = similar_discrim(state1,state2,sim=nearest_k(Expected_state_reward))


The idea is that your context vector should be dependent on your estimate of where you will end up getting your reward from. So base the context vectors off the nearest_k predicted vector and use the power of global discriminators to give this nice properties of uniformity and transitivity.

The biggest weakness is the state and reward predictor. The usual problem of deep networks will rise up badly for this sort of thing. 

I would guess that this vector should be combined with a unsupervised context vector somehow, especially if you are getting sparse rewards, or have a low number of training examples.

But once that is done, you can go back and try out the ideas in procedures 1 to get rare states, which will now be rare based off how they behave in the expected reward space.
