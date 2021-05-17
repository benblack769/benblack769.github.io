---
title: "Hybrid chess engine"
slug: chess-engine
under_construction: false
excerpt: "A chess engine that attempts to combine the strengths of Lc0 and Stockfish, the two dominant chess engines, and succeeds in certain cases."
comments: false
share: false
code: "https://github.com/benblack769/lc0-stockfish-hybrid"
img: /images/chess_engines/vis_graphs/thousand/sf_tactical.svg
post_date: "2019"
---


Lc0-stockfish-hybrid is a (mostly) UCI-compliant chess engine based off two separate projects, [Stockfish](https://stockfishchess.org/) the leading traditional chess engine, and [LC0, or leela](https://lczero.org/) the leading open source neural network chess engine based off AlphaZero.

## Code

Code is publicly available [on Github](https://github.com/benblack769/lc0-stockfish-hybrid).  If you need windows or Linux binaries, you can contact me at benblack769@gmail.com.

## Hybrid Project

Both the Lc0 chess engine and the Stockfish engine are extremely strong, and have been dramatically improving due to improved heuristics for Stockfish, and improved training for Lc0. However, they are very different engines, based off very different methods and strengths, and so the goal is to combine those strengths.

![hybrid_image](/images/chess_engines/stockfish_lc0_hybrid.png)

### Comparable strengths and weaknesses

* In head to head matches, typically Lc0 wins reliably, but Stockfish is better at beating weaker engines (avoiding draws more successfully), so Stockfish still wins many engine tournaments.
* On the hardware in these tournaments, Stockfish evaluates around 60,000,000 nps, whereas Lc0 evaluates around 60,000. This is 3 orders of magnitude difference, yet they evaluate to a similar depth in most positions (around 35), indicating that Stockfish sees a much wider tree, better evaluating more tactics positions, whereas Lc0 sees a deeper tree, evaluating deep endgames and positional weaknesses using its vastly superior heuristic.
* Lc0 is not trained well for winning endgames. It can draw completely winning positions because it thinks every move is winning, including some that are not. In tournaments, a tablebase has to be used to mitigate this problem.
* Stockfish is relatively bad at openings. Opening books are not allowed in tournaments, and Stockfish's heuristic is not able to evaluate the complex middle game positions that openings produce.
* Lc0 is relatively bad at tactics, dropping pieces in short time controls.

So how to combine Stockfish's ability to win games and handle tactics with Lc0's ability to evaluate positions?

### Algorithm description

The core position evaluation algorithm is Lc0's Monte Carlo Tree Search (MCTS) Algorithm cloned from the AlphaZero paper. There is one change:

*In MCTS selection, do not select moves that Stockfish has evaluated as bad.*

This algorithm can be implemented much more efficiently than you would think. Contrary to appearances, Stockfish's core loop outputs a binary output. It does alpha-beta search where alpha and beta are the same number, so the only output of the core loop is whether the estimation evaluation is above or below alpha. To then compute the actual estimated value it reports, it does a binary search over candidate values. This central loop is extremely highly optimized, so using it directly is going to be extraordinarily efficient. This efficiency issue is a large part of the inspiration for the above algorithmic change.

In order to implement the algorithm completely, there are several aspects to consider:

1. What is a bad move?
2. How deep does Stockfish search to determine if a move is good or bad?
3. What does Lc0 do if Stockfish has not determined whether the move is good or bad yet?

There is also a relevant design question: how does a seemingly crude binary criteria to explore edges in the tree produce high quality evaluations?

#### What is a bad move?

Moves that Stockfish thinks are bad are easy to characterize: A move is bad if it is 60 CP (centi pawns, a measure of material advantage) *worse* than Stockfish's evaluation of the root board position (this constant is a tunable hyperparameter).

To implement this efficiently, there is one thread computing the value of the root position, and many other threads evaluating whether the moves all over the tree are "bad" under the above criteria (or both players).

#### How deep does Stockfish search?

Stockfish's evaluation loop uses an iterative algorithm which slowly increases the search depth of the engine. Inspired by this approach, the algorithm does the following:

* All moves on all nodes that Lc0 explored at least once are evaluated to depth 3 (this is a tunable hyperparameter).
* Evaluation upgrades are given priority based off the following formula

$$\frac{Node Weight}{Computation Time}$$

This formula is designed so that fast evaluations are prioritized and evaluations which Lc0 weights highly (meaning it has searched the node many times) are also prioritized. Computation time is estimated to be the computation time of previos searches of the move.

####  What does Lc0 do if Stockfish has not determined whether the move is good or bad yet?

This is simple, Lc0 assumes all moves are valid if Stockfish has not computed anything yet.

#### Why does this algorithm produce stable, high quality evaluations despite a seemingly crude exploration criteria?

One interesting feature of this algorithm is its builtin stability. If Stockfish rates a move as "bad" incorrectly, because of a shallow search depth, that does not prevent the *node* from being searched by Lc0, only the *move*. So if the *node* continues to be searched, the *move* which is weighted based off how often Lc0 explored the *node*, not the *move*, will continue to move up the priority queue until it is reevaluated by Stockfish at a greater depth.

Many similar variations on the algorithm I tried failed miserably because it did not have this self-correcting feature.


### Visualizations for algorithm

While it is hard to visualize a huge game tree, small parts of the game tree can be visualized to understand what the method actually does.

The numbers at each nodes in the graph (and the thickness of the borders) represent how many times the node is visited in the MCTS simulation (the number of subnodes that are evaluated). The red lines are edges which Stockfish has decided are definitely bad, and which will no longer be explored (but their values are still included in the evaluations of parent nodes, for evaluation stability). Nodes with less than 5 children are pruned.
<!--![A](/images/chess_engines/vis_graphs/hundred/nosf_middle.svg)
![A](/images/chess_engines/vis_graphs/hundred/sf_middle.svg)
-->

#### Tactical positions

Here is a evaluation graph in a sharp middlegame position where every single move is forced, the kind where Stockfish shows its best strengths.

Vanilla Lc0 evaluating 1000 nodes
![A](/images/chess_engines/vis_graphs/thousand/nosf_tactical.svg)

Hybrid approach with Lc0 evaluating 1000 nodes
![A](/images/chess_engines/vis_graphs/thousand/sf_tactical.svg)

As you can see, adding the Stockfish signal completely changes the resulting evaluation tree. In particular, note that the tree searches much deeper, presumably because Stockfish's signal eliminates enough moves that it is more confident about where it should search.

Of course, Stockfish generally does make the best move in these sort of positions, so you might wonder why you can't just have Stockfish make the move, but the idea is that sometimes there might be two possible moves with very sharp subtrees that terminate in very positional endgames, and you still want Lc0 to evaluate the conclusion of different forced moved sequences.

#### Positional positions

Here is an evaluation graph of a very slow middlegame where Stockfish thinks that at least 10 moves at each node for 5 move are OK, i.e., it has no strong opinions about the position. Lc0 seems to evaluate the position better, as the hybrid engine eventually beat Stockfish from this position, despite the signal from Stockfish being quite useless.

Vanilla Lc0 evaluating 1000 nodes
![A](/images/chess_engines/vis_graphs/thousand/nosf_middle.svg)

Hybrid approach with Lc0 evaluating 1000 nodes
![A](/images/chess_engines/vis_graphs/thousand/sf_middle.svg)

In this case, the evaluation tree still changes, but much less than in the tactical position. Many parts of the subtree are similar, the depth of various parts of the tree are similar. This means that when Stockfish is not as strong in the position, it does not interfere with Lc0's normal evaluations very much.
