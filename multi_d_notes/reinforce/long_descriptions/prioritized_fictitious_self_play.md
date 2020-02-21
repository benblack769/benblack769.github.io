### Uses in AlphaStar

Given learning agent *A*, sample  frozen opponent *B* from set of canidates *C* with probability

$$\frac{f(P[A \ \text{beats} \ B])}{\sum_{D\in C}f(P[A\  \text{beats}\  D])}$$

Where $$f: [0,1] \rightarrow [0,\infty)$$ is some weighting function

Choosing $$f_{\text{hard}}(x) = (1-x)^p$$ make PFSP focus on the hardest players where $$p \in R$$ scales the distribution.

Choosing $$f_{\text{var}} = x(1-x)$$ means that the agent prefers opponents around its own level, which is best for agents which are much weaker overall than the strongest agents.

### Criticism

In the [Transitive Cyclic Decomposition](/#transitive_cyclic_decomposition) paper, this method is criticized because it contracts the space of agents rather than expands it.

In particular, in the [disk game](/#disk_game), this method contracts the space of solutions instead of growing them (this method is version C in the diagram).

![game_response](linked_data/game_response.PNG)

They instead propose [Response to Rectified Nash](/#response_to_rectified_nash) to grow the landscape.
