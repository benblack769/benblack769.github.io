
### Overview

Fictitious self play is a method for finding solutions to zero-sum games.

It basically is just accumulating best responses by both players iteratively to converge to some mixed strategy. 

### Theory

The idea is this. Each player's has a set of possible pure strategies, so player $$A$$ has strategies $$\{A_1,...,A_n\}$$, and player $$B$$ has strategies $$\{B_1,...,B_m\}$$.

Each pair of strategies is associated with an outcome.

The solution works by each player building a set of strategies which in the end will be uniformly sampled from by the players. The mixture strategy represented by uniformly sampling from the set represents their current strategy.

1. Start with player $$P = A$$
1. Player $$P$$ picks strategy $$P_i$$, which maximizes its outcome against its opponent's current mixed  strategy
1. Add that strategy to player $$P$$'s set.

### Citation


#### Original paper that introduced the idea (very hard to find actual paper)

G.W. Brown, Iterative solution of games by fictitious play, in: Activity
analysis of production and allocation (T.C. Koopmans, Ed.), pp. 374-376,
Wiley: New York, 1951.

#### Paper that proved the result

```
@article{10.2307/1969530,
 ISSN = {0003486X},
 URL = {http://www.jstor.org/stable/1969530},
 author = {Julia Robinson},
 journal = {Annals of Mathematics},
 number = {2},
 pages = {296--301},
 publisher = {Annals of Mathematics},
 title = {An Iterative Method of Solving a Game},
 volume = {54},
 year = {1951}
}
```
