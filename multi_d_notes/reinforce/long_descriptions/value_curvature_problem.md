Out of sample value estimation is known to be a hard problem. However one would home that RL should be capable of producing conservative value estimates.

Ordinarily this should be solvable with double Q networks. If one network is biased upwards, use the other network--chances are it will be biased downwards. The problem is then systematic bias. But what systematic bias can occur?

1. Extrapolation: You have several points signaling that going a particular direction will be beneficial. So you keep going, until pathological collapse. Overparameterized policies should help?
2. Parabolic: Many points around the same, one point further away and up. Most natural way to model this is with a positive curvature model.
