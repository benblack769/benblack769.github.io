This builds upon the ideas of [Response to the Nash](/#response_to_nash) but creates niches for strategies in order to widen the game space.

In particular, this method considers all the agents which have support in the Nash equilibria. This means that an optimal strategy will play each of these agents sometimes. Then, when training new agents, it only trains those agents against opponents which lose to it.

### Emperical Evidence for success.

In the [Transitive Cyclic Decomposition](/#transitive_cyclic_decomposition) paper, this method is emphasized because it expands the space of agents.

In particular, in the [disk game](/#disk_game), (this method is version B in the diagram).

![game_response](linked_data/game_response.PNG)

This makes it better than [Prioritized fictitious self play](/#prioritized_fictitious_self_play) (version C in the diagram).
