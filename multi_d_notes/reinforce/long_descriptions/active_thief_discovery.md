
### Guard thief game

The guard thief game is when the guard is trying to locate the thief, but does not know where the thief has traveled, and the thief is trying to find some objects in the space, but does know where those objects are. When the guard finds the thief, the game is over. In real life, the game might transition to a pursuit-evasion game, but here the game simply ends for simplicity.

Here is an example: the guard is green, the thief is blue, and the points to steal are red. The yellow is the path the thief is currently trying to follow.

<video class="loop_video" controls muted width="250">
    <source src="linked_data/robo_proj/dynamic_house_vid.mp4"
            type="video/mp4">
    Sorry, your browser doesn't support embedded videos.
</video>

Note that since the agent's sight radius is greater the the guard, it can successfully avoid the guard a significant proportion of the time.

### No information guard-thief game

But what if the guard had a greater radius of sight than the thief. In this case, since the game ends as soon as the guard sees the thief, and since sight is symmetric, the guard and thief will never see each other for the duration of the game!

This makes for some interesting game theory as I will talk about.



### Solving the game

This no information game can be modeled as a simultaneous game where each player picks a path at the start of the game, and then follows this path until the guard sees the thief, or the game ends.
