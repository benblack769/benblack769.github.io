<style>

blockquote {
  padding-left: 1em;
  border-left: 0.2em solid rgba(0,0,0, 0.4);
}
</style>

Deepmind's StarCraft 2 AI creates strategy statistics with a hand-crafted compilation method, no learning involved.

### example

Copied from [nature paper](https://www.nature.com/articles/s41586-019-1724-z.epdf?author_access_token=lZH3nqPYtWJXfDA10W0CNNRgN0jAjWel9jnR3ZoTv0PSZcPzJFGNAZhOlk4deBCKzKm70KfinloafEF1bCCXL6IIHHgKaDkaTkBcTEv7aT-wqDoG1VeO9-wO3GEoAMF9bAOt7mJ0RWQnRVMbyfgH9A%3D%3D)

> From each replay, we extract a statistic z that encodes each player’s build order defined as the first 20 constructed buildings and units, and cumulative statistics, defined as the units, buildings, effects, and upgrades that were present during a game.



### During supervised learning


### During reinforcement learning

When a new agent is created, it is supervised based off that statistic throughout its run, i.e. the agent is penalized for not following the statistics.

One example is build order. If the agent ends up choosing a different build order, then it its penalized strategy statistic's build order, it is penalized with a hand-crafted loss.
