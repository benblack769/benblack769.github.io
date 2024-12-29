---
title: "Hashlife w/webassembly"
slug: robotics-project
under_construction: false
excerpt: "A simple, effective hashlife algorithm in rust and viewer in javascript/webassembly. "
comments: false
share: false
post_date: "2023"
img: /images/hashlife/hashlife_splash.png
code: "https://github.com/benblack769/hashlife-rust"
priority: 0
---

Awhile ago, I wanted to play around with web-centric computing using webassembly and rust. For a project, I picked out the hash-life algorithm, an super-fast algorithm for simulating Conway's Game of life. 

The app looks like this (<a href="https://benblack769.github.io/hashlife-rust/" target="_blank" rel="noopener noreferrer">click to go to deployed demo</a>):

<a href="https://benblack769.github.io/hashlife-rust/" target="_blank" rel="noopener noreferrer">
![screenshot](/images/hashlife/full_app_screenshot.png)
</a>

To test the full power of the hashlife algorithm, I would recommend:

1. "Select builtin pattern" and selecting either "twinprimes.rle"
2. Pressing both "fast-forward" button and the "skip" button a few times
3. Increasing the brightness to the max
4. Waiting for a few seconds.

You should see the results look something like this:

![twinprimes-screenshot](/images/hashlife/twinprimes.png)

Note that the dots coming out of the machine correspond one to one with the twin primes! This works because the machine acts like a prime sieve, eliminating all non-primes, and then also eliminating unpaired primes.

* Code here: [https://github.com/benblack769/hashlife-rust](https://github.com/benblack769/hashlife-rust)
* You can learn more about hashlife here: [https://www.dev-mind.blog/hashlife/](https://www.dev-mind.blog/hashlife/)

#### Key learnings

* The toolchain for developing wasm and js bindings from rust is pretty mature. I was able to do everything without any trouble. 
* It is easiest to start out without build tooling, and add that it later if you need to plug it into a larger project.
* Remember that webassembly doesn't have great support for garbage collection. Programming in rust helps with this.
* It is fun to implement an algorithm like this without frameworks


<!--

Simulation remains a considerable challenge for computers, and a very active area of reaserch (if you are not already familar with it, check out the youtube channel [Two minute papers](https://www.youtube.com/c/K%C3%A1rolyZsolnai)). One key trick that complex physics engines, such as fluid dynamics engines use is to model groups of particles as a single higher level abstractions such as [vorticies](https://en.wikipedia.org/wiki/Vortex). Another key trick is to partition particles into sectors where only low level interactions within a sector matter, so interactions between sectors can be ignored.

While physicists and computational scientists have developed some fabulous abstractions and partitioning strategies and deployed them effieciently on hardware, us computer scientists wonder if there is some principle that would allow these higher level abstractions to be automatically determined, perhaps through some sort of machine learning model.

With real physics, its really hard to develop a concrete training regime that we can have confidence will work. But we computer scientists are not limited to real physics, and can work with simpler physics models that are more approachable.

Today, we will look at [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) as an example physics regime. If you are not familiar with this system, you can play around with it [here](https://conwaylife.com/).

There are three properties of this system which are very useful for efficient simulation:

1. The particles are laid out on a grid. This makes for easy and efficient partitioning.
2. The particles values are discrete. This means we can used a hard hash to memoize the results, essentially a trivial machine learning method.
3. The "speed of light", i.e. the fastest that information can travel, is known and quite slow. This means we do not need to make any assumptions when partioning or building abstractions, out results will be exact.

![](/images/hashlife/checkerboard.gif)
 -->