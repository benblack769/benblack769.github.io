Capsule network's activation works as follows:

The layer's output is divided into a number of capsules. Each capsule is activated using the following function

$$ v_j = \frac{\|s_j\|^2}{1 + \|s_j\|^2} \frac{s_j}{\|s_j\|} $$

### Citation:

```
@article{DBLP:journals/corr/abs-1710-09829,
  author    = {Sara Sabour and
               Nicholas Frosst and
               Geoffrey E. Hinton},
  title     = {Dynamic Routing Between Capsules},
  journal   = {CoRR},
  volume    = {abs/1710.09829},
  year      = {2017},
  url       = {http://arxiv.org/abs/1710.09829},
  archivePrefix = {arXiv},
  eprint    = {1710.09829},
  timestamp = {Mon, 13 Aug 2018 16:47:11 +0200},
  biburl    = {https://dblp.org/rec/journals/corr/abs-1710-09829.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
