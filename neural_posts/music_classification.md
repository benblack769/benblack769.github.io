## Intro to music classification

Music analysis has a history of vagueness and subjectivity. Hearing the same sets music, people disagree on which ones were more similar to one another. This is because music has many aspects. Theorists focus on chord progressions. Dancers focus on rhythm and energy. Movie viewers focus on mood changes.

But even when a single subject is chosen to focus on, say chord progressions in melodies, then there are significant computational problems with extracting this information from raw sound, and then trying to model it in some way reasonably similar to human understanding of the subject.

These two issues have made the community of automated music analysis researchers build complex software with tons of features, allow for different machine learning algorithms and meta-learning in order to manage all this complexity.

We want a single way of capturing all this information into a single, easily analyzable vector. Custom uses can use standardized algorithms to use these vectors for whatever they may want.

## The algorithm

The algorithm is inspired by word2vec, a natural language processing tool. The key idea extracted from word2vec is to compare sounds based off their causal relations, instead of their physical properties.

By causal relation, I mean simply this: Two sounds have a temporal relation if one is followed by the other. Two sounds have a causal relation if this temporal relation is robust, meaning it happens in different contexts.

There are several ways of defining a temporal relation, but perhaps the simplest is to divide up the song into time steps, and simply say that time step $t$ has a relation with time step $t+1$.

Robustness is ensured by training over diverse datasets and having a restrictive algebraic structure which does not allow for significant overfitting.

#### Note on terminology

You might wonder why I am calling robust temporal relations "casual relations", instead of just calling them what they are. The reason is that it is much easier to tie these technical ideas to human ideas of music and sound analysis if you think of them this way. I hope one day to show that the associations you make by using these terminologies are useful for creating working applications, and are not just a gimmick.

### Single level song2vec
