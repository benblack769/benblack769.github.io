# Ramsey algorithm

## Ramsey problem

## Idea

There is a certain conflict between the

## Current visualization of algorithm

[link](/link_only/ramsey-algo/ramsey_vis)

## Proofs, explanations needed


One weird thing is the lack of symmetry. Edges are symmetric, so shouldn't vertices also be symmetric? I don'

## Possible improvements

1. Randomization
Looking at it, it converges way too fast. I suspect it may hit a cycle and stop, even if there is improvement to be had.
The way to randomize this would be to run the iterative thing for awhile, and do a discrete probability distribution. No need for binary search, since we only need this once for one graph. Perhaps we should use the softmax function for those probabilities, rather than the regular one since we really never want to change "good" edges.
2. There is no clear termination of the algorithm. Perhaps we can run it for awhile, and check the minimum value of an edge.
3. Deterministic check for cliques. This can be used to help see when to stop the random algorithm, or to visualize the algorithm finding better and better graphs. It is also necessary to prove anything using this technique.
