### Signal

The signal is just a series of values computed by a recurrent network over time.

Rather than necessarily oscillating up and down like a neural signal, the RNN will have
the capacity to alter its signal more freely.

### Signal reinforcement

A strong signal is one with significant magnitude and is steady over time. Steady over time in this case means:

 Sign (+/-) is predictable based off past signals (i.e. wavenet style, but doesn't predict magnitude).

So a signal is strong if its direction can be predicted from a time series of just that value (disregarding neighboring values).

So the prediction network will output a value *v*, which will be the confidence its sign is the same sign as *v*. For stability, there should be a limit to how large *v* can be (squash to [-1,1] using tanh).

The action network will output a value *s* which is the signal. This will not necessarily be limited in magnitude. In fact, the activation function of this value should not be a squashing function at all, but an explosion function. This will allow the destructive interference to encourage high amplitude signals over low ones when they are the same.

The reward of the prediction network will be (cross entropy of the prediction vs the sign) × f(the magnitude of the signal).

Note that these values can all be vectors, not just scalars. The difference is that the prediction network will have more data to predict off of. Note that they shouldn't be too large, or else the whole concept of a "strong signal" gets lost.

### Destructive interference

The idea behind destructive interference is that neurons are naturally inclined to replicate each other's behavior, which is wasteful.
the first idea you might have is to negatively reward for replicating each other's behavior. But it is too inefficient for all pairs to interact, so also very inefficient and difficult, and unclear how local pairs will interact in this way.

So instead, the idea is instead of destructive interference of the signal reinforcement, destructively interfere with the signal directly.

The idea is that a signal comes from a pool of energy. Strong magnitude signals draw from this pool rapidly, weak ones draw slowly. The magnitude of the activation is squashed by a function of the amount left in the pool. The pool is filled at a constant rate. If many strong signals constantly draw from the pool, then they will become weak signals. If signals draw from the pool inconsistently, then they will not be predictable, and will learn slowly. If a weak signal and a strong signal are activating at the same time, the strong signal should be reinforced quickly, the weak signal should be reinforced much more slowly such that it will eventually go and learn something else instead. This is helped by the exploding single neuron activation function. 
