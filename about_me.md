---
title: About Me
permalink: /about_md/
---

So here is the deal with me.

I fell in love with programming just 8 weeks into my first programming class in high school, when I made a tictactoe AI. What I loved is that I completed something I didn't quite understand, and could beat me at the game handily, because while I was tired and unfocused and made terrible moves, my AI just chugged along anyways. This cemented my "hands off" way of programming AI: if I have to understand the game to program the AI, I am doing something wrong.

When I was 10 years old, my friend in elementary school made a pencil and paper game, which I then turned into a strategy board game. It was hideously complicated and unbearably slow to play, due the fact that each player moves around dozens of units around the board per turn, and there are hundreds of turns per game. So I only ended up playing it one time ever (depite making two copies of the board game).

So I turned the board game into a computer game, giving it a simple GUI. However, I did not know how to make a multiplayer game, so instead I dived into making an AI. Over the next year and a half, I spent around 10 hours a week on this, developing a number of hand-coded strategies, locally greedy strategies, dynamic programming strategies, and tons of heuristics to go with it. I knew absolutely nothing about AI theory when doing this. I rewrote the game 2 times, and the GUI 3 times, and the AI 3 times, all from basically scratch. Total number of hours spent was probably around 1000.

But the thing was, nothing worked. Nothing even came close to working. And it was so hard to play, that I couldn't even tell very well when it wasn't working. So I built in all sorts of visualization and debugging capabilities into my final AI, and realized that all my ideas were crap.

I mothballed that project halfway into my second programming class ever, freshman year of college, when I realized that there was a lot more out there than what I could figure out myself, and maybe, just maybe, someone had already understood how to make things work. So while I held to my original ideal that you should not have to understand the game to solve it, perhaps there are some pricipled approaches you do have to understand in order to solve games like this.

So over the next few years, I dived into traditional algorithms because they beautifully explain when a solution definitly works. I also spent hundreds of hours rewriting code over and over to get better at writing good code the first time, so I wouldn't have to rewrite code every time I did anything.

But the problem was, these algorithms and clean code didn't solve my problems either. I wanted to learn how social networks and "the world is small" effects form. I wanted to be able to learn how different risk management strategies play out in the long run. I wanted to make an AI to that damn game that actually works.

And make no mistake, I really tried a lot of things.

Here is a short rundown of some of my more memorable failures:

* [GraphOptimizer](https://github.com/weepingwillowben/GraphOptimizer): A theano-like compiler for neural networks. Horrifically slow and stupid, as it works on the level of scalar operations, instead of vector operations. But I still was able to train MNIST with it, made a c++ backend to help with speed, and it had a quite nice API.
* [city_gen](https://github.com/weepingwillowben/city_gen): A project to simulate a city scaled down to a project to simulate a road planning system. I ended up making a greedy algorithm that improved the road segement which was the most immidiately useful one to improve. I made an interactive interface for this algorithm as well.
* [CubeDynamics](https://github.com/weepingwillowben/CubeDynamics): I was excited about neural network's ability to simulate physics, and so I made a voxel based physics simulator. It was decent at simulating fluids, as you can see from [the youtube links on this page](https://github.com/weepingwillowben/CubeDynamics), but actual crap at simulating solids, and since I was more interested in solids, I realized that the whole approach was absolute garbage.
* [sound-eval](https://github.com/weepingwillowben/sound-eval): A project I worked on along side a reaserch group that was using doc-to-vec. The goal was to make document vectors for audio files. I made a couple ([final version](https://s3-us-west-2.amazonaws.com/fma-dataset-embeddings/display_template.html), first approach ([words](http://s3-us-west-2.amazonaws.com/classical-piano-display/words/display_template.html), [files](http://s3-us-west-2.amazonaws.com/classical-piano-display/docs/display_template.html))) of cool browser visualizations of the different approaches I had. However, they ultimately were useless because their properties weren't strong enough and people weren't interested enough, so it died because no one knows it exists (not to mention that there were smarter people around who probably have done a better job by now).
* [lc0-stockfish-hybrid](https://github.com/weepingwillowben/lc0-stockfish-hybrid): This project's goal was to combine the strengths of lc0 and sockfish, the leading two chess engines which use entirely different techniques and algorithms to play chess. I had some promising initial results on my approach, and was very excited, but as I continued to get my evaluations more precise, I realized that the approach had always been crap, and I didn't have the resources to try the fixes I knew were necessary to proceed.

One unifying theme of all of these is that I worked on them entirely by myself, to the degree where I didn't tell people that the first 3 ever existed, and quickly told people to forget about the last 2 when it became clear that they didn't work very well. I rarely looked anything up, and never tried anything that seemed complicated or hard to explain.

But these 5 projects, along with the original board game project (which was a far larger effort than any of the later ones), all had small elements of success. These successes, heighted by the total independence of thought I had; these failures, heighted by my sole responsibility to the project, tranformed my view of how progress is made in these subjects.

I developed very strong feelings about what approaches are useless because they do not generalize. I developed this sense that demos and visualizations were the *only* way to communicate algorithmic ideas unless the anylitic proof is airtight (which it never is in AI).

Related to all this, I had an emotional crisis as I was graduating. How could I live in a world that demands things of me, while also trying my best to live up to my own standards of what does and does not make sense to do?

So I was thinking, maybe what I am missing is other people. People who know things I don't know. People who can do all these things I have shied away from. But I would also stand up and make sure that I still do things my own way, and try to connect to others only when our goals align.
