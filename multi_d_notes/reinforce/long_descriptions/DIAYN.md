
### Basic idea

DIAYN maximizes information about an episode while maximizing entropy.

Leads to unsupervised skill discovery.

### Algorithm

System tries to maximize mutual information between environment state and random source.

Discriminator evaluates mutual information between the two.

Policy tries to maximize discounted discriminator reward over time.

Entropy is maximized via SAC entropy regularization.


```
@article{DBLP:journals/corr/abs-1802-06070,
  author    = {Benjamin Eysenbach and
               Abhishek Gupta and
               Julian Ibarz and
               Sergey Levine},
  title     = {Diversity is All You Need: Learning Skills without a Reward Function},
  journal   = {CoRR},
  volume    = {abs/1802.06070},
  year      = {2018},
  url       = {http://arxiv.org/abs/1802.06070},
  archivePrefix = {arXiv},
  eprint    = {1802.06070},
  timestamp = {Thu, 20 Dec 2018 16:30:14 +0100},
  biburl    = {https://dblp.org/rec/journals/corr/abs-1802-06070.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
