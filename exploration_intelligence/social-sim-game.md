

## Goal

Make a playable game which allows us to understand and try different social roles, and see realistic results of those roles.

The goal is to help people reflect on their own ideas of how the world should work, and how their ideas play out in reality. The goal is not to build reality, but rather, just enough to see realistic results of many core ideas about themselves and the world.



## Guiding Method

* Every game mechanic should be simple and mechanical, but continuous as possible. This will help implementability and ballanceability.
* Social factors will not be hardcoded except where absolutely necessary, and instead will be learned by individual level weak learners.

## Game environment

Intelligence occurs when there are complex tradoffs to be made. Social intelligence occurs when there are many locally optimal solutions which require significant levels of collaboration.

### Game tradeoffs

* Fighting vs keeping your health
* Thievery vs Work
* Sleeping vs Awake
* Reproduction vs self-preservation
* Good location vs low competition

These ideas can all be done within a simple fighting game mechanics:

* food kill drops
* person-person trade
* health impacts on productivity
* sleep deprivation penalties
* specific locations to work for food
* reproduction/with significant long term health loss.

This simple model should work extremely well for playability, and should also allow natural social behavior in theory.   

### Global environment

In order to get the location based tradeoff, the environment should be varied. This tradeoff is important because it will drive societal variation, which is good.

For a first, just make food centers where one can "work" for food have some distribution over the map. Perhaps there will be more complicated mechanics later.

## Individual intelligence


### Communication

Emogis?

### Base options

Continuous as possible to allow for gradual learning.

If continuous not possible, then probability distributions of choices

### Learning

This is the hard part.

#### Need some sort of state creation method to compress over time series.

* One option is a simple pattern repetition method that picks up sequences of actions, and gives an option to repeat the sequence.

#### Needs a strong, but fast reinforcement learning method that allows for valuing long term goals

#### People need to be able to recognize other people as themselves and copy others, and learn from other's mistakes

### Personality Configuration

People need to differ from each other both socially and physically to introduce specialization

Genes??
