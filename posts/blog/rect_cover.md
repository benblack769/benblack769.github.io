---
title: "Fast, Simple, Effective Rectangle coverage"
slug: rect-cover
under_construction: true
excerpt: "Using Rust, R-Trees, submodular optimization theory, and clever tricks to implement fast, simple, effective, rectangle covering strategy."
comments: false
share: false
post_date: "2023"
img: /images/rect_cover/rect_cover_splash.png
priority: 4
---


## Rectangle coverage

The inspiration for this problem comes from a real world challenge I encountered when translating human object annotations into inputs for a deep learning system at [Techcyte](https://techcyte.com/). In this buisness, domain experts review gigapixel whole slide image scans, and box interesting objects that they find. They are instructed to only label exemplars, that is, the clearest, most distinct objects, and they don't worry about comprehensive labeling. However, small objects are often labeled in the same generall area of the scan, for convienience of the human annotator, so there are sometimes many annotations grouped together. 

Neither humans nor standard deep learning systems can examine gigapixel images in one go---the task must be broken up into smaller tasks that can fit into memory. Typically, this is done through simple tiling strategies. However, since since annotations are not expected to be comprehensive, the deep learning system's loss function is customized to ignore all unlabeled objects during training. So tiling unlabeled areas is wasteful. And so efficient tile generation becomes a covering task, where we wish to generate tiles which cover all the areas of the image where there are human annotations, and to ignore all the areas which there are no human annotations. Furthurmore, our object detection problem is easier if each object is fully contained within the scene. So we require full containment as a constraint.  

We can reduce this to an abstract constrained minimiztation problem as follows: Given a tile size of `(X, Y)` and a set of boxes `{(x, y, w, h)...}`, we must generate a set of tile coordinates such that every object is contained within at least one tile, and within those constraints, we hope to minimize the number of tiles.

A sneak peak of the algorithm in action is shown below:

![algorithm-sneak-peak](/images/rect_cover/rect_cover_norm.gif)

## Analogous problems

This algorithm has close relationships to two better known algorithms:

1. [Set-cover](https://en.wikipedia.org/wiki/Set_cover_problem) (Given a bunch of sets of elements, find the minimal selection of sets so that you get every element)
2. Radial cover (think covering an area with radio towers)

Set-cover is a nice analogue because our problem can be directly reduced to it. In our problem, the total set you want to cover is the set of all annotations. The subsets you wish to select from are the tiles which contain them. Unfortunately, [set-cover is known to be NP-hard](https://en.wikipedia.org/wiki/Set_cover_problem)

The NP-hardness of set-cover should give us pause. Even though the geometric limitations of rectangular cover means that it might not be NP-hard, this correspondence to set-cover means that it will still likely be expensive to compute an exact solution. Note that radial cover problems are also generally fairly hard to find exactly optimal solutions to.

So we can turn to approximation algorithms with a good concience that we are probably not passing by some efficient exact solution. Set-cover is known to have a simple, and fast approximation algorithm: [Greedy selection](https://en.wikipedia.org/wiki/Set_cover_problem#Greedy_algorithm). In our language, greedy selection means simply choosing the tile which covers the most so-far uncovered objects, removing those objects, and repeating. Unfortunately, this greedy algorithm is known to have a worst case bound of `O(log(N))`. Even worse, it is a tight lower bound for polynomial time algorithms: set-cover has an inaproxiability result that states that simply achiving better than `O(log(N))` is also NP-hard.

While again, it is unlikey that this inapproximability result is valid in the 2d case, you can construct some pretty bad examples of the greedy algorithm for our rectangular cover problem. For example:

Take the following arrangement of squares, and the following simple green tiling that produces the optimal solution of 4 tiles.

![greedy-case-opt](/images/rect_cover/greedy_case_opt.png)

Now, consider that the greedy algorithm will start with the densest area in the center and edges, and work its way to the sparser areas on the corners, generating this inefficient 9 tile solution.

![greedy-case-greedy](/images/rect_cover/greedy_case_greedy.png)

So at the very least, the greedy algorithm is a 9/4 solution. Which isn't ideal. It is also a bit tricky to implement this global greedy algorithm efficiently, as there are many possible canidate tiles to choose from when trying to find the globally best tile each iteration.

So we cannot rely on the correspondence to set-cover to find a good approximation algorithm, and instead must find some specific geometric properties which allow for better approximations with simpler, faster implmentations. However, we are pragmatic people not geomtry wizards, and the greedy solution isn't bad, so what we can do is explore the problem by trying to find efficient implementations and heuristics for the greedy solution.

## Geometric analysis

To understand this problem more closely, we can identify and solve a bunch of related sub-problems to understand the full problem better.

### Canidate selection

One good question inspired by the greedy solution is: Question 1, *How would we go about finding the best single tile that covers the most rectangle, in a scene?*

Well, one way to do this is to narrow down all the possibly optimal tiles, to a finite set, and check them all. Giving us a new problem, Question 2 *How can we enumerate all possibly optimal tiles*?

To start, consider this set of rectangles and associated tile:

![rect-cover-orig](/images/rect_cover/rect-cover-orig.svg)

Notice that this tile can be shifted around by a considerable amount without changing which tiles it includes. It can be shifted even more if we allow it to include at least all the same tiles it started with, and possibly more. 

To reduce the set of possible tiles so can hope to enumerate all of the possibly optimal ones, we can try to normalize each tiles to a similar tile that includes at least as many objects as the orignal.

Raising the Question 3: *How can we take any given tile, and generate an equivalent, easily defined tile, that includes at least as many objects?*

Well, one simple way would be to shift the tile down and right to the very edges of tho extremal objects contained in the original tile, e.g.

![rect-cover-shifted](/images/rect_cover/rect-cover-shifted.svg)

And you end up with a tile which contains *at least* as many objects as the original. Answering Question 3.

Since all optimal tiles are equivalent to a tile which has a left-most and top-most object, we can generate a set of possible optimal canidates by simply considering all top edges and left edges of all boxes, and considering canidate tiles which fully contain the boxes which generated it (not necessarily distinct). This operation is `O(N^2)` where `N` is the number of boxes. This is already polynomial, a good start to Question 2. But N can  be in the hundreds of thousands in the problem domain, so `O(N^2)` just is too slow in practice.

To reduce the complexity of this generation problem furthur, we can utilize the geomeric sparsity of objects. In the problem domain of consideration, labels are fairly sparse over a huge gigapixel region. So we should only consider object pairs which are are close enough that they could fit in the same tile. To do this, we can choose the left-most object first, and then only choose top-most objects which can be contained in the same area as the left-most object. This area can extend in the y axis until the tile can no longer contain the lower edge of the chosen left-most object. Similar for the lower bound. So the area to look is exactly the region `(x1: b1.x1, y1: b1.y1 + b1.height - tile_height, width: b1.width + tile_width, height: tile_height * 2 - b1.height)` where `b1` is the left-most object. We can use a fast containment checking method to find all objects inside that region, such the method described in [my earlier post](posts/blog/box_search/). This allows us to find all viable left-top pairs of objects which define a possibly optimal tile in approximately `O(M*N*log(N))` time, where `M` is the number of objects which intersect with the worst. Which is still quadratic in the dense case, but much smaller in the sparse case. So this is a still better answer to question 2.

However, we will need to check each canidate tile again to count how many objects are contained within each tile. Which will take at least M time, if done naively, yeilding a complexity of `O(M*M*N*log(N))` time, which is cubic, and is asking for trouble. When you go through the logic, you start to feel that it seems inefficient to iterate through the `M` objects in the given region to enumerate canidate tiles, just to iterate over those same objects again when evaluting those canidate tiles. Yielding question 4: Can we generate canidate optimal tiles and evaluate them at the same time?

The trick to question 4 is realizing the simplicity of the x dimension in our region of search. Every possibly optimal tile has the same x coordinate. So we only have to search along the y coordinate. So we can reduce this 2 dimensional rectangle cover problem to a 1 dimentional interval cover problem. The one-dimensionality means we can utilize sorting and counting to perform this evaluation exactly in `O(N*log(N))`. The details get a bit complicated, but the idea is powerful, and allows us to get a solution to question 2 in `O(M*N*log(N)*log(M))` time.

This final trick is pretty cool. It means that given a left-most box, we can find the tile that includes the most rectangles very quickly.

### Left to Right strategy

The problem with the global greedy strategy comes from the O(N^2) number of canidate tiles, especially in the case of dense, small objects.

However, why start with the densest area of the region? In set-cover this is a logical approach because there is no other easily identifiable extrema to start from. But in a 2d region, we have other extrema. In particular, consider the globally left-most rectangle. Any solution will have at least one tile which includes this rectangle, and of course, this rectangle will be the left-most rectangle in that tile, since it is the left-most rectangle globally. 

Also, we have an efficient method, answered in question 4, of finding the locally optimal tile, given the left-most object. So instead of proceeding our greedy algorithm globally, we can instead proceed greedily from left to right.

Unfortunately, the theoretical worst-case bound that we inherited from set-cover no longer applies. So we are left in theoretical limbo, uncertian to how good this solution is, in the worst case. We could generate some synthetic benchmarks, and see what the results are. And on the benchmarks I generated, it does indeed out-perform global greedy solutions by some margin. But without worst-case analysis I am left nervous that it will generate some really embarassingly poor solutions.

So I tried to construct a worst-case solution, and got this:

![left-to-right-worst-case](/images/rect_cover/left_to_right_worst_case.png)

A bit more examination reveals that this type of construction can yield a solution arbitrarily bad.



Consider this alternative strategy:

1. Take the left-most object in the entire scene (with arbitrary tie-breaks)
2. Take the whole region of possible canidate tiles, and go through the objects left to right, fitting in tiles, and adjusting the possible region as necessary to fit them

### Approximation bound

Theorem: This algorithm is an 2 approximation of the rectangle cover problem, in that if the optimal solution gives *N* tiles, this algorithm will give at most *2N* tiles.

### Approximation lower bound

Here is a worst case example where the greedy algorithm gives 3 tiles to the optimal solution's 2 tiles, giving a lower bound of a 1.5 approximation. Consider the following arrangement of 5 tiles. 

![](/images/rect_cover/rect-cover-worst-case-sample.svg)

Given the below tile size, the greedy algorithm produces 3 tiles:

![](/images/rect_cover/rect-cover-worst-case-greedy.svg)

Wheras the optimal solution is clearly to produce 2 tiles, for example:

![](/images/rect_cover/rect-cover-worst-case-opt.svg)

### Algorithm upper bound

This sort of example is also the worst case. This proof assumes the typical assumption in computational geometric of inexactl alignment (LOOK UP PROPER TERM FOR THIS)



Proof:

Take a set of boxes *B*.

The left-most box `lb = min_x(B)`, the region around which the tile must be selected for that box: `lr = {x1: lb.x1, y1:lb.y2 - tile_height, x2: lb.x1 + tile_width, y2: lb.y2 + tile_height}`.

Now run the greedy algorithm until another box inside `lr` is chosen as the left-most remaining box.

Without loss of generality, since the y axis is symmetric at this point in the argument, say that this box is higher in `y` than `lb`, and call it `lhb`.

Keep running the algorithm until another box inside `lr` is chosen. Note that this box cannot also be higer than `lb`

Note that 

Note that the optimal solution of `B'` is at worst the same count as the optimal solution of `B`.

Contained inside the region `lr`, examine the remaining boxes lower than, and greater than `lb`. If it exists, say left-most box which is lower in y than `lb` is `llb`, and the left-most box which is greater in y than `lb` call it `rlb`. If 

Take an optimal solution to the rect covering of boxes *B*. Now, this optimal solution must include 1 tile which has its left-most edge be the edge of 

