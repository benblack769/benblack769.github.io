The core of this method is the Intrinsic Curiosity Module(ICM):

![ICM](linked_data\icm.PNG)

$$r_t^i$$ is used to augment the reward during policy training, and $$\hat{a}_t$$ is used as a learning target to train the feature generators, and is not used elsewhere.

This method suffers from the [TV problem](/#tv_problem).

### Citation

```
@article{DBLP:journals/corr/PathakAED17,
  author    = {Deepak Pathak and
               Pulkit Agrawal and
               Alexei A. Efros and
               Trevor Darrell},
  title     = {Curiosity-driven Exploration by Self-supervised Prediction},
  journal   = {CoRR},
  volume    = {abs/1705.05363},
  year      = {2017},
  url       = {http://arxiv.org/abs/1705.05363},
  archivePrefix = {arXiv},
  eprint    = {1705.05363},
  timestamp = {Mon, 13 Aug 2018 16:48:59 +0200},
  biburl    = {https://dblp.org/rec/journals/corr/PathakAED17.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
