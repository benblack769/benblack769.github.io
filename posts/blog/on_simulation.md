---
title: "AI and Simulation"
slug: process-code
under_construction: false
excerpt: "Why simulation will become increasingly important in an AI dominated technology world, and how I discovered this by making a low quality simulator."
comments: false
share: false
post_date: 2018
img: /link_only/on_simulation/videos/still_img.png
---

Computer simulation is a very cool subject. It affects our lives in accurate weather reporting, and continuing improvements in efficiency of vehicles and airplanes. More importantly, it allows for cool animations such as the snow in Frozen. But accurate, large scale modeling and simulation is very difficult. From an engineering perspective, it is one of the greatest challenges in software and hardware development.

Why is simulation so hard? Well, take a relatively simple simulation scenario to learn from: **object collision**. Take this demo of the [Matter-js, a javascript 2d simulation library](http://brm.io/matter-js/)

<script src="https://cdnjs.cloudflare.com/ajax/libs/matter-js/0.12.0/matter.min.js"></script>

<div id="rendered_canvas"></div>

<button id="refresh_button">Refresh</button>

<script>

{% include javascript/on_simulation/example_sim.js %}

</script>

Each element in the simulation is fairly simply to model with a computer. The circles can be described with the position and radius, the ropes with the position of the two ends.

The effects of gravity and velocity can be easily calculated with high school level physics.

But what about objects colliding? It turns out that while object collision may seem to be a simple task because it is so familiar in physical reality, but in our modeled reality where position is a number, rather than a location, it is computationally intensive. Why is this? It turns out that computationally, calculating a collision of a pair of objects is fairly strait forward. Now, the formula for collision is a little difficult, and usually takes me a couple of hours to rederive whenever I need it, but it only takes a few dozen processor instructions, and so the computer can execute it very fast. What is hard is calculating whether there is a collision at all. The easiest solution is to check every pair of objects, but if you have n objects, this takes n^2 time. So, if you have 1000 objects, the collision calculation will take 100 times more time than if you had 100 objects. In physics simulations with tens of billions of objects, as in some supercomputer simulations, this is quite impractical.

So instead of trying to check if each pair of objects is close enough to collide, computers such as the javascript library that makes the above newton's cradle simulation make elaborate datastructures which allow very fast closeness searches.

So many simulations have this setup. A complex system is divided into small portions which are described with simple, mathematical models. So there are two difficult parts: the modeling and designing efficient interactions.

Of the two, the modeling is what makes simulation inaccessible. State of the art modeling in the most useful areas such as fluid dynamics, weather prediction, and computer graphics are the result of decades of academic research and commercial development.

Amateurs who try to make a custom model of a world from scratch, such as Dwarf Fortresses, end up with a deeply flawed product that barely ends up being passable to a human. While interesting phenomena do sometimes come out, really stupid phenomena also do. This is fine in a game, less so in a scientific application.



### More complex simulations

Modern AI has had most of its greatest successes so far by solving simple classification, optimization problems. Which person does this photo of a face represent? Does this brain scan have signs of disease in it, and if so, which disease? Is this audio input representing a part of a word, and if so, which word part? All of these reduce a large, complex input space (usually images or sound), and output a small, simple and discrete output space (a probability or set of probabilities). So you might think of it as reducing and distilling the information in the input. Naftali Tishby's Information Bottleneck theory formalized this idea, and it has emerged as one of the only broadly known theories in deep learning.

These techniques have gotten mature incredibly quickly, and so far superior to older techniques in this way that it heralds a new way of working with computers. The best discussion of the implications is Andrej Karpathy's medium article discussing Code 2.0 ([medium link](https://medium.com/@karpathy/software-2-0-a64152b37c35)).

But the same techniques used to output these simple probabilities also used to do much more complex tasks. Generative networks, especially adversarial generative networks have shown that neural networks and gradient descent can be used to solve whole new problem areas. Unlike the above mentioned classification techniques, in generative networks, the output is at least as big and complex as the input. Especially in auto-encoding networks, the output, usually an image, is generated from a relatively small encoding vector. Generative networks are being used to great effect in systems biology.


But what is computer simulation really capable of? How much further can it push science and engineering? And of most interest to me, can it change the way we interact with the world?

When I started out on this project, I was starting to believe that simulation was about to see a major leap, driven by development of generative deep learning models. Generative deep learning has seen some major commercial applications recently, including generating computerized voice on the Google Home platform.

Inspired by these new innovations in generating images, and old innovations in simulation originating in speeding up the game of life (see [here](intelligent-code/on_simulation/#game-of-life) for more on the implications of cellular automaton on simulation), I started on a project to make an everything simulator.

### My local interaction simulator

The idea was to create a slow, but simple "ground truth" simulator, which a deep generative network could then copy.

Since deep networks work best with dense ground truth data, I figured it would be best if the simulator was naturally represented in a dense form to start out with.

This combined with ideas from cellular automata that interactions between objects can be represented as local computations, allowing massive parallelism (the implementation uses OpenCL to utilize GPU parallel processing power).

#### Liquid simulation

The problem then comes down to creating formulas and states for the cells which simulate physical interaction. For liquids, they tend to have both attractive forces (surface tension) and repelling forces (density). A very intuitive implementation of that gives rise to the following simulation:

<video width="600" height="400" controls>
<source src="/link_only/on_simulation/videos/compressed_video.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

#### Solid simulation

What about solids? It turns out that solids are much harder. In particular, they have this crystalline structure which makes reactions to collisions extremely fast! This makes it unsuited for this cellular automata at a deep level, as cellular automata are inherently inefficient at representing fast moving objects. But some solids are more malleable than others, for example jello may not react as fast to collisions as quartz. So can we simulate jello? I'm not sure, but I couldn't manage to get it to work. The problem is that while local interactions should work, it seems as though a more discrete spring model is needed, which cannot be represented cleanly in a cellular automata framework. If you want, you can see one of my failed attempts.

<video width="600" height="400" controls>
<source src="/link_only/on_simulation/videos/bad_jellies_short.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>


### More videos:

<video width="600" height="400" controls>
<source src="/link_only/on_simulation/videos/compressed_long.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

<video width="600" height="400" controls>
<source src="/link_only/on_simulation/videos/compressed_splatter.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

<video width="600" height="400" controls>
<source src="/link_only/on_simulation/videos/compressed_splatter.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>
