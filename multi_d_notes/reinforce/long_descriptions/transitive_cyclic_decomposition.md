
## Symmetric zero-sum Functional form games

A functional form game is described by an antisemetric function
$$\phi(v,w) = -\phi(w,v)$$
that evaluates a pair of agents

$$\phi: W \times W \rightarrow \mathbb{R}$$

Where the higher the value of $$\phi(v,w)$$, the better for agent $$v$$. $$\phi = 0$$ is a tie.

The proof here is that every game can be transformed into a sum of a transitive and a cyclic game.

### Transitive games

A game is **transitive** if there is a rating function $$f$$  such that performance on the game is the difference in ratings:

$$\phi(v,w) = f(v) - f(w)$$

Note that this optimal value for one player is not dependent on the other player, and so it can be found by training against a fixed opponent at least in theory. In practice, when the probability of winning of either side gets to be too high learning slows down significantly, so playing against an opponent of similar strength is best, which is why self-play works so well.

### Cyclic games

A game is **cyclic** if

$$\int_{W}\phi(v,w)\cdot dw = 0 \ \ \forall v \in W$$

In other words, wins against some agents are necessarily counterbalanced with losses against others.

#### Disc game

An example of an entirely cyclic game is the disk game.

Let $$W = \{x \in \mathbb{R}^2 : \|x\|_ 2^2 \le k \}$$

$$\phi(v,w) = v^T \cdot  \left( \begin{smallmatrix} 0&-1\\ 1&0 \end{smallmatrix} \right0)\cdot w$$

Note that Rock Paper Scissors embeds in the disk game:

![disk_game](linked_data/disk_game.PNG)

Here is another time Deepmind shows off this game in [their blog](https://deepmind.com/blog/article/AlphaStar-Grandmaster-level-in-StarCraft-II-using-multi-agent-reinforcement-learning).

![blog_disk_game](linked_data/rpc_game.webp)


### Citation

```
@article{DBLP:journals/corr/abs-1901-08106,
  author    = {David Balduzzi and
               Marta Garnelo and
               Yoram Bachrach and
               Wojciech M. Czarnecki and
               Julien P{\'{e}}rolat and
               Max Jaderberg and
               Thore Graepel},
  title     = {Open-ended Learning in Symmetric Zero-sum Games},
  journal   = {CoRR},
  volume    = {abs/1901.08106},
  year      = {2019},
  url       = {http://arxiv.org/abs/1901.08106},
  archivePrefix = {arXiv},
  eprint    = {1901.08106},
  timestamp = {Sat, 02 Feb 2019 16:56:00 +0100},
  biburl    = {https://dblp.org/rec/journals/corr/abs-1901-08106.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
