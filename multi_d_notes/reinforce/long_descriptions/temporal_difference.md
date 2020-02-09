
### Overview

Specialized for prediction problems.

Conventional prediction: error between predicted and actual

Temporal Difference: error (difference) between temporally successive predictions

Better than supervised by an actual RL signal because it is incremental.

### TD(λ)

The parameter λ introduces a recency bias that makes the method weight more recent samples more highly.  

Formally, for
$$ 0 \le \lambda \le 1 $$, we have

$$ \Delta w_t = \alpha (P_{t+1}-P_t) \sum_{k=1}^t \lambda^{t-k}\nabla_w P_k$$

Note that if $$\lambda = 1$$ then we have the uniform sampling distribution, where all diffs in the future are weighted equally,
and if $$\lambda = 0$$ then we have the singleton distribution where only the next diff matters. 

## Bibtex Citation

```
@article{article,
author = {Sutton, Richard},
year = {1988},
month = {08},
pages = {9-44},
title = {Learning to Predict by the Method of Temporal Differences},
volume = {3},
journal = {Machine Learning},
doi = {10.1007/BF00115009}
}
```
