
### Overview

Idea is to simply have many Q functions that train on different data segments.

During training, a certain run of the policy just follows the greedy policy of a single Q function all the way to the end. Then, when the Q-function is getting updated via the DQN update method (including memory replay, etc), that head is only trained on data that it's policy generated.

Generalization between functions is handled by the neural network sharing weights between the different functions, i.e. the functions are just "heads" of the neural network. Generalization can also happen by choosing to instead train a point *p* created by executing the policy associated with  head *w* on a different head.

In other words, this method works by allowing more biased variations, especially at the beginning of training. But you shouldn't expect this to work all the time because you should expect that you need more variation than just initialization will allow for.

Here are some good and no so good results. 

![results](/linked_data/boot_dqn_results.PNG)

### Video explanation

[link](https://www.youtube.com/watch?v=e3KuV_d0EMk&feature=youtu.be)

### Citation

```
@article{DBLP:journals/corr/OsbandBPR16,
  author    = {Ian Osband and
               Charles Blundell and
               Alexander Pritzel and
               Benjamin Van Roy},
  title     = {Deep Exploration via Bootstrapped {DQN}},
  journal   = {CoRR},
  volume    = {abs/1602.04621},
  year      = {2016},
  url       = {http://arxiv.org/abs/1602.04621},
  archivePrefix = {arXiv},
  eprint    = {1602.04621},
  timestamp = {Mon, 13 Aug 2018 16:46:32 +0200},
  biburl    = {https://dblp.org/rec/bib/journals/corr/OsbandBPR16},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
