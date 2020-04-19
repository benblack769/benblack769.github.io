Jean Piaget's idea of learning centers around this idea of alignment.

That a [schema](#schema) can be completed, and afterwards learn extremely slowly by itself, or it can learn much faster by aligning with another schema.

This idea of alignment is also prominent in the Self-supervised learning literature, but they do not do a good job, learning best from extremely separated signals, and according to Piaget's observations, humans do an extremely good job, learning even from conflagrated signals like in vision.

In order to reproduce this power, this problem of alignment needs to be solved.


You have a network which takes in some input, does something, and gets some reward.

You have another network which takes in some input, does something, and gets some reward.

The key is that some of these inputs are going to be from the network, and the rewards are going to be broadcasted globally and locally.

So both networks do something at the same time. This means that some subnetworks are receiving the others signals and using it in some (random) way. These subnetworks notice the success of their outputs, and align their inputs to produce the outputs more frequently.


### Alignment and assimilation

Alignment can be viewed as the mechanism behind assimilation.
Assimilation means to bring into the fold, to make something external and foreign part of the whole. This can be done with an act of alignment. A pattern, global difference or object can be brought into the fold by aligning all the senses that respond to this new object together. So as you scan across it, there is a signal your neurons produce, and reward circuits that activate, and actions you perform, and an object is included in the schema if they are internally consistent, that is, 
