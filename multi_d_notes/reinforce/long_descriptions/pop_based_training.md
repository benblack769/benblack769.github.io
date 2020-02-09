### Population based training (PBT)

Population based training is an evolutionary way of tuning hyperparameters based of memetic algorithms.

Idea is to have a bunch of agents, all training, and their hyperparameters change over time due as they interact.

### Application to alphastar

In AlphaStar, there is a

* selection process: tournament results
* Highly changing loss surface due to strategic interactions and value function learning

Which makes it suited for PBT.

## Citation

```
@inproceedings{10.1145/3292500.3330649,
author = {Li, Ang and Spyra, Ola and Perel, Sagi and Dalibard, Valentin and Jaderberg, Max and Gu, Chenjie and Budden, David and Harley, Tim and Gupta, Pramod},
title = {A Generalized Framework for Population Based Training},
year = {2019},
isbn = {9781450362016},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
url = {https://doi.org/10.1145/3292500.3330649},
doi = {10.1145/3292500.3330649},
booktitle = {Proceedings of the 25th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining},
pages = {1791–1799},
numpages = {9},
keywords = {wavenet, speech synthesis, evolutionary algorithms, black-box optimization, population based training, neural networks},
location = {Anchorage, AK, USA},
series = {KDD ’19}
}
```
