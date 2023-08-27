---
title: "Fast, Simple, Effective Rectangle coverage"
slug: rect-cover
under_construction: false
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

We can reduce this to an abstract problem as follows: Given a tile size of `(X, Y)` and a set of boxes `{(x, y, w, h)...}`, we must generate a set of tile coordinates such that every object is contained within at least one tile, and within those constraints, we hope to minimize the number of tiles.

A sneak peak of the algorithm in action is shown below:

![algorithm-sneak-peak](/images/rect_cover/rect_cover_norm.gif)

## Algorithmic approach

First, we can decompose this problem along the typical optimizatation method of generate->score->optimize:

1. **Canidate selection**: How to find and generate promising tile canidates?
2. **Fast Containment**: How can we do these containment checks quickly to score/rank canidate tiles based on how many objects they contain?
3. **Optimization**: What fast and effective strategies can we use to prune the set of canidates down to an approximately minimal set?

#### Canidate selection

Canidate selection is made much easier by the rectangular structure of the problem. It is furthur simplified by the fixed width and hight of the tiles.

These two constaints mean that each tile is fully specified by its left and top edges. To reduce the set of optimal canidates furthur, a analysis and cleverness is needed. Note that every tile has an object that is furthur left than every other object in the tile, and an object that is furthur up. 

![rect-cover-orig](/images/rect_cover/rect-cover-orig.svg)

Now, that tile can be shifted down and right to the very edges of those extremal objects.

![rect-cover-shifted](/images/rect_cover/rect-cover-shifted.svg)

And you end up with a tile which contains *at least* as many objects as the original.

Since all optimal tiles are equivalent to a tile which has a left-most and top-most object, we can generate a set of possible optimal canidates by simply considering all top edges and left edges of all boxes, and considering canidate tiles which fully contain the boxes which generated it (not necessarily distinct). This operation is `O(N^2)` where `N` is the number of boxes. This is already polynomial, a good start, but not quite fast enough. 

To reduce the complexity of this generation problem furthur, we can utilize the geomeric sparsity of objects. In the problem domain of consideration, labels are fairly sparse over a huge gigapixel region. So we should only consider object pairs which are are close enough that they could fit in the same tile. To do this, we can choose the left-most object first, and then only choose top-most objects which can be contained in the same area as the left-most object. This area to look is exactly the region `(x1: b1.x1, y1: b1.y1 + b1.height - tile_height, width: b1.width + tile_width, height: tile_height * 2 - b1.height)` where `b1` is the left-most object. Any objects which are not contained in this region cannot be successfully contained in the same tile as the left-most object `b1`. And we can use the fast containment checking method described in the next section to find all such objects in approximately `O(M*log(N))`, where `M` is the number of objects which intersect with that region. Yielding an algorithm with `O(M*N*log(N))` where `M` roughly represents the greatest number of objects in the same tile-sized area. Still quadratic in the worst case, but much smaller in practice.

#### Fast containment

At a high level, we hope to construct a fixed tree-based data structure of all your boxes (human annotations) so you can quickly check how many objects any given tile canidate contains. Luckily, I just did [a project on fast rectangle intersection](/posts/blog/box_search/) to solve similar problems for the same company. And containment can be solved efficiently with brute force checking once intersection is established.

The data structure described in that post is clever, but is known in the literature, and does not require much code. A high level overview follows: each node in the tree is a bounding box of all the objects in the tree below it. This data structure is known as an R-Tree. This can reduce the size of the search problem because if a tile doesn't overlap with that bounding box, then you don't need to check any of the objects underneath that node of the tree. To generate nodes with small bounding boxes it is standard to use recursive sorting (alternating sorting and partioning along x and y axis) to group objects together. This is known as Recursive Tile Sort. More details are in the [original post](/posts/blog/box_search/), but hopefully this gives an idea.

#### Optimization

This algorithm has close relationships to two better known algorithms:

1. [Set-cover](https://en.wikipedia.org/wiki/Set_cover_problem) (Given a bunch of sets of elements, find the minimal selection of sets so that you get every element)
2. Radial cover (think covering an area with radio towers)

Set-cover is a nice analogue because our problem can be directly reduced to it. In our problem, the total set you want to cover is the set of all annotations. The subsets you wish to select from are the tiles which contain them. Unfortunately, [set-cover is known to be NP-hard](https://en.wikipedia.org/wiki/Set_cover_problem)

The NP-hardness of set-cover should give us pause. Even though the geometric simplicity of rectangular cover means that it is probably not NP-hard, it will still likely be expensive to compute an exact solution. Note that radial cover is also thought to be fairly hard to find exactly optimal solutions to.

So we can turn to approximation algorithms with a good concience that we are probably not passing by some efficient exact solution. Luckily, set-cover is known to have a provably effective, simple, and fast approximation algorithm: [Greedy selection](https://en.wikipedia.org/wiki/Set_cover_problem#Greedy_algorithm). In our language, greedy selection means simply iteratively choosing the tile which covers the most so-far uncovered objects. And the correspondence to set-cover's provable approximation bounds of `O(log(N))` is suggestion that this algorithm is good enough to achive good results. Interestingly, there is also theory that within a constant, this is the optimal polynomial time algorithm for set-cover, suggesting that we would need to utilize the geometric structure of rectangular cover to perform better. Which I didn't try today. But if you want to give it a shot, I encourage you to!

Now that we have settled (for now) on this broad greedy strategy, we just need to find a way to execute this strategy quickly. 

The strategy chosen is a simple strategy which minimizes the quantity of extra memory, data structures, and code required, at a constant time computational cost. 

1. construct a priority queue of the best scoring tiles. 
2. Pick best tile off of queue
3. Re-compute that tile's score, masking out chosen boxes
4. If that 

Naively scoring the tiles using the intersection checker is an `O(N * M^2 * log(N)))` operation, as there are `O(N * M)` tiles, as there are `O(M)` tiles generated for each object in the densest areas of the region, and each scoring operation takes `O(M log(N))` to count all the containments. In a relatively sparse system, where `M` is below 50, this complexity is quite acceptable. 

