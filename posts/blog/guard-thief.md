---
title: "Guard-thief problem"
slug: guard-thief
under_construction: true
excerpt: "Optimization instability in adversarial guard-thief game planning."
comments: false
share: false
post_date: "2020"
img: /images/guard_thief/guard_thief_splash.png
priority: 4
---

In graduate school, a result in a course project in a robotics class ended up changing my intended direction of study for the next year in a half, and completely changed my view of AI as a whole. This life-changing result can be summarized from a single chart: the learning curve below (solid lines are the marginals, light line are the means):

![Instability report](/images/guard_thief/many_guards.json_report.csv.png)

Ok, what is so exciting about this chart? Well, by itself, it could be any sort of issue with the learning algorithm. However, I had previously convinced myself, with extensive iteration and visualizations, that the code was doing what it should be doing, and actually learning good policies, and secondly, I knew from the literature that the algorithm in question was based off of a multi-agent population response method that was known to converge under weak assumptions. So, like every scientific discovery, the excitement was that one of these assumptions that looked pretty robust, was actually false in this case, and in fact, would likely be false in most circumstances which one would apply adversarial AI to.

So I was hoping to share the problem at hand and the reasons it is so life-changing.

## Guard-thief problem

In robotics, there is a lot of asymmetric, zero-sum games which involve a guard which is protecting space, and a thief which are trying to avoid the guards, and find certain waypoints of interest. There are a bunch of different models of what kind of information each agent has access to.

1. What line of sight does the guard have?
2. Does the guard have to chase down the thief after seeing them?
3. Does the thief already know the layout of the area and the waypoints they are targeting?

### Game definition

After some iteration, the following set of rules were settled upon to make an practically interesting and tractable problem definition:

1. The guard has limited lines of sight, blocked by both obstacles, and by distance. 
2. The game ends when the thief is seen by the guard, or when the thief finds all waypoints. The thief scores all the waypoints that were found before being seen, the guard is scored by the waypoints not found. (making it zero-sum)
3. The guard and thief start out with perfect information about the scenario. (making it a planning problem, i.e. zero-information)

TLDR, its a patrolling problem, where the guard patrols the areas where he thinks the thief is likely to be at a given time-point, and the thief tries to approach the waypoints while avoiding areas where the guard is likely to be. 

### Practical motivation

The solution to this game can be used for stochastic patrol design. One problem with deterministic patrols (that is exploited so much in action movies) is that the thief can learn the patrol routes, and find gaps and weaknesses in them. 

However, unlike in the movies, in reality, patrols need not be planned deterministically, rather, like rock-paper-scissors, the guard rotation can randomly choose from a distribution of patrols (even a small sample can be effective), and assuming the selection process is hidden from the thief, then the thief cannot avoid the patrol for certain, and must take calculated risks.

The guard is probably best off assuming that the thief is highly intelligent and highly informed, like the ones in the movies, and should model the possible thief as the worst case scenario, that the thief chooses the best possible route given the patrol distribution, and the guard should adjust their patrol distribution accordingly to account for this.

This intuitive iterative "Best response" optimization is the foundation of our solution methodology.

### Example maps

Before getting to far into the methodology, I hope to show some examples of what this looks like. In the below visualization, there are 50 different samples of guard and thief paths being displayed on top of each other. In each simulation, there is only one guard and one thief, and the particular simulation ends when that guard and thief intersect, or when the thief finds all the waypoints.

<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_7.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

Note the different strategies the thief take. 

1. The "speedrun" strategy, running through the corridor, catching the waypoints as quickly as possible.
2. The "retreat" strategy, which picks up the first waypoint before retreating and picking up the second waypoint on the other side of the wall.
3. The "hide" strategy which picks up the first waypoint before hiding on the outside of the building for awhile, before heading back in, hoping the guard is on the other side of the division.

And then sub-strategies of the above.

Each of these strategies have counter-strategies from the guards, and most thief are caught. But on some occasion, the guard encounters a thief that it's path never encounters, and so in 7 of the 50 simulations, the thief manages to pick up all 6 waypoints.

Note that the limitations of this map (such as the starting locations being fixed, and there only being one guard and one thief) are not needed for the optimization strategy below, which is powerful enough to accommodate variable starting locations or numbers without significant inefficiencies.

## Game solution

A solid, efficient, effective solution, that improves with the more computation time you give it is essential, for both practical and scientific usecases. It is also not easy, and requires a variety of techniques in optimization, planning, game theory, and parallel programming. So its worth going into detail go into detail about how one solves a game like this.

At the highest level, the "Best Population Response" method is used for multi-player optimization. The idea is to calculate the best response for one player against to the existing set of solutions for the other player. Once that best response is calculated, it will be added to the population of strategies for that player. For zero-sum games like this one, This method which was proven in the 1950s to produce a uniquely scored nash equilibria[CITATION], i.e. a global minima. This means that after convergence, neither agent could benefit from switching strategies.

### Best response optimization

Additionally, since the agents do not have any instance specific information about the other agents, they do not have to make any game-specific choices. This means that solutions do not need to have function policies that intake observations, instead, the policies are static, and can be parameterized by long paths through the map. I.e. a strategy is simply a path.

To find the best response path to an opponent, we can use a genetic algorithm, using the existing set of paths as a strong baseline set to start from.


To make this generic algorithm efficient, the genetic algorithm operates on high level target points, which an ordinary pathing algorithm converts into a continuous path. These target points are added, removed, shifted, swapped out, etc, in the mutation and crossover steps.

The scoring is done by checking all paths in the opponent population one by one. A single pair of (guard, thief) paths is efficient to check, simply by iterating along each timestamp and checking the respective visibility of the guard and thief for the victory conditions. With pre-computed visibility tables, a particular game score can be calculated in a few hundred CPU cycles. Some more details of the algorithm and implemnetation optimizations can be found in [Appendix A](#appendix-a-implementation-details).

### Implementation

The full implementation can be found [on github](https://github.com/benblack769/robotics_project) with some instructions in the readme which can be used to reproduce the most of the plots and videos in this post. Map construction and pre-computation is performed in python, and the optimization is performed in c++.

## Results/Discussion



## Appendix

### Appendix A: Implementation details

So, in pseudo-code the algorithm is simply:

```
thief_paths = [random_path()]
guard_paths = [random_path()]
loop
    seed_thief_paths = [random_path()]*10 + random.sample(thief_paths, k=100)
    for i in range(GENETIC_ITERS):
        seed_thief_paths = crossover_mutate(response_thief_paths)
        thief_path_scores = population_response_score(seed_thief_paths, guard_paths)
        seed_thief_paths = filter_by_score(seed_thief_paths, thief_path_scores, count=100 if i != GENETIC_ITERS-1 else 1)
    thief_paths.append(thief_path_scores[0])
    # same thing for the guards
```

Additional important optimizations include:

1. Pre-computing the visibility function of the guard, so that the question of whether the guard can see the thief at a given timepoint is a simple table lookup. 
2. Pre-computing the thief's capture space so that the thief finding a waypoint is a table lookup.
3. Parallelizing the NxM `population_response_score` step using OpenMP.
4. Parallelizing the `crossover_mutate` step.

### Appendix B: More results

So you can get a better idea of how training progression works visually, here are a full sample video from different steps in the population accumulation process.

#### Video Step 4
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_0.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 11
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_1.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 20
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_2.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 32
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_3.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 44
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_4.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 58
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_5.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 74
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_6.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 90
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_7.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 108
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_8.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 126
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_9.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 145
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_10.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 166
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_11.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Video Step 187
<video width="600" height="400" controls>
<source src="/images/guard_thief/progression/many_guards_vid_12.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>
