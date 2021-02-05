Here is the basic idea. We want to be able to localize cost to a small set of states so that output can affect that estimate of cost in a significant way, allowing for fast learning. However, the set of states is huge. So we need to condense it somehow.

State: External state + internal state

Internal state is a compression of external state, done by recursive feature extraction.


Then the high level intelligence can more easily isolate the internal state as the "cause" of the cost, and adjust outputs accordingly.
