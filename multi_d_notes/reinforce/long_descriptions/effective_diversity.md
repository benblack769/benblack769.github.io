Measures of diversity typically quantify differences in
weights or behavior of agents but ignore performance. Effective diversity measures the variety of effective agents
(agents with support under Nash):

### Definition

Notation from [Transitive cyclic decomposition](\#transitive_cyclic_decomposition).

Given population $$B$$, let $$A_{ij} = \phi(w_i,w_j)$$ be the strategy payout matrix of the population.

let $$p$$ be a Nash equilibria on $$A$$ (note that this is just a vector of probabilities).

Let

$$\lfloor x \rfloor_+ = \left\{ \begin{array}{lr} 0 & \text{ if } x \le 0 \\ x & \text{ if } x > 0 \end{array} \right\} $$

 denote the relu rectifier

Then the **effective diversity** of the population is

$$d(B) := p^T \cdot \lfloor A \rfloor_+ p$$


Note than the rectification of  $$\lfloor A \rfloor_+$$ implies that we only add interactions which are good for the first player (but players are symmetric).

### Algorithm to solve

The [Response to rectified Nash](/#response_to_rectified_nash) algorithm directly uses this as its objective and proceeds greedily. 

### Citation

Citation in [Transitive cyclic decomposition](/#transitive_cyclic_decomposition)
