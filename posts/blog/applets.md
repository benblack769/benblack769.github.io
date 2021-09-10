---
title: "Web applets for reaserch"
slug: web-applets
under_construction: true
excerpt: "Using hacky web applets to investigate reaserch questions."
comments: false
share: false
post_date: "2021"
---

## Menu

* [Ramsey Theory](#ramsey-theory)
* [Multiplicative Weights for Stock estimation](#multiplicative-weights-for-stock-estimation)
* [Sound Vector visualization](#sound-vector-visualization)
* [Graphical Notes](#graphical-notes)

### Ramsey Theory

Ramsey theory is one of the more mysterious parts of combinatorics. The foundation is a simple question: given $$ g $$ guests can you guarantee that at least $$ m $$ will know each other or that $$n$$ will not know each other?

Well, it turns out that this question is hard to answer. A much easier question is the dual: given $$g$$ guests, can you find a solution where no $$m$$ guests know each other and no set of $$n$$ guests do not know each other.

Most progress in Ramsey theory has been in solutions to this dual problem. However, even this question is hard. Why?

First, lets simplify the problem even further and say that $$m=n=k$$. Call $$g$$ the graph size. Then, we can start to build a simple greedy solution to the problem.

Keep adding edges (meaning two guests know each other) in the place which increases the maximum clique size the least. We are done if the maximum clique size has not reached $$k$$ and the minimum clique size is not zero.

Below is the applet which runs this exact algorithm:

[Ramsey numbers](https://benblack769.github.io/link_only/ramsey-algo/ramsey_vis.html)

<script src="/link_only/ramsey-algo/greedy_add.js"></script>
<script src="/link_only/ramsey-algo/graph_draw.js"></script>
<div>
    Graph Size
    <input type="number" value=30 id="graph_size"/>
</div>
<div>
     K Size
    <input type="number" value=4 id="clique_size"/>
</div>
<button onclick="greedy_execute()">Update Graph</button>
<p id="num_display"></p>
<p id="output_display"></p>
<canvas id="myCanvas" width="1000" height="1000">
</canvas>

After playing around, notice that the algorithm starts to choose random looking edges, despite being entirely deterministic in nature. This gets to one of the core themes in Ramsey theory: tight solutions to the dual are random looking--perhaps even more random looking than a truly random graph. Researchers have discovered fascinating connections between tight Ramsey graphs and invertible cryptographic grade encryption functions.

This app was written entirely in javascript. The JS code draws the graph by simply drawing on an HTML canvas. About as simple as a web applet as is possible.


### Multiplicative Weights for Stock estimation

When I first learned about the multiplicative weights update algorithm, I immediately started thinking about applications in the stock market. One of the guarantees of the multiplicative weights algorithm is that you cannot do too much worse than the best expert. So I thought I would come up with some stock selection strategies and see if the multiplicative weights algorithm would do well.

I built a static website with lots of daily stock data and a frontend application which processes the data via a number of heuristic strategies. A strategy is considered "correct" if it correctly predicts whether the stock will go up or down on a particular day. I also built a multiplicative weights update algorithm using those heuristics as experts. You can visit the application by following the link below:

[Stock multiplicative weights](https://benblack769.github.io/link_only/stock_vis/stock_vis.html)

If you visit the link and play around with my app, you will find that:

1. All the heuristics have a very poor predictive quality pretty much all the time.
2. The multiplicative weights update algorithm is sometimes the worst heuristic of all of them!

This gives two important insights about the algorit:

1. It requires that the experts actually be pretty good consistently over a long period of time.
2. It can be worse than any particular expert!

It also shows that the stock market is really noisy, and binary "up/down" indications of the stock market are not likely to be predictable.

<!--
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/metrics-graphics/2.11.0/metricsgraphics.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/d3/4.12.0/d3.min.js' charset='utf-8'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/metrics-graphics/2.11.0/metricsgraphics.js"></script>

<script src="/link_only/stock_vis/stock_list.js"></script>
<script src="/link_only/stock_vis/multiplicative_weights.js"></script>
<script src="/link_only/stock_vis/stock_predictors.js"></script>
<script src="/link_only/stock_vis/stock_predictor.js"></script>
<script src="/link_only/stock_vis/stock_vis.js"></script>

<h3> Stock label </h3>
<select id="stock_options"></select>
<h3> Stratgy parameters </h3>
<div>
    <input id="number_days" type="number" value=10>Number of days</input>
</div>
<div>
    <input id="average_over" type="number" value=60>Average over #</input>
</div>
<div>
    <input id="bullish_discount" value="0.1">Bullish Discount</input>
</div>
<div>
    <input id="mul_weights_constant" value="0.1">Mul Weights constant</input>
</div>
<h3> Stratgies to include </h3>
<div id="strategy_inclusion">
</div>
<br>
<h3> Make sure to update chart after changes </h3>
<button id="update_chart">Update Chart</button>
<div id="stock_chart"></div>
<h3> Results </h3>
<div id="pred_chart"></div>
-->

### Genealogy generator

I was working for [Marc Bedau](https://people.reed.edu/~mab/), a Philosophy professor at Reed College who was working with scientists to understand the deep nature of real work problems. The problem he was interested in at the time was patents. Given that new patents emerge from old ones, what does that genealogy tree look like? What characteristics does it have? Are there any patterns? Can we visualize it effectively?

One of the necessary steps is simply being able to work with hyper-parental trees (genealogy trees where a child can have more than 2 parents), and understand the dynamics of how inheritable traits tend to change under simple assumptions. Previous work had studied how single traits change, but not how multiple traits change. So I made an interactive web-app to allow my professor to easily click around and understand this multi-trait behavior through manual interaction.

The frontend simply makes a call to an AWS lambda service, which calls the legacy python code and the graphvis tool to generate the visualization.

If you are curious, you can see the application below.

[Genealogy generator](https://benblack769.github.io/link_only/aws_lambda_client/graph.html)

### MIDI Vector visualization

While I was working for that same philosophy professor, I started getting going on my own project. This project was to use the word2vec and doc2vec unsupervised learning algorithms to embed audio files into a space where notions of movement, distance, etc, correspond to changes in the actual nature of the music. Using more advanced clustering tools the professor was working with, he was even hoping to understand musical change over time.

A MIDI file, at its simplest, is just a sequence of notes/chords, durations and volumes. I simply ignored the volumes and durations, and treated it as a sequence of chords (a chord is a combination of notes). The word2vec algorithm was then applied to this, placing each chord into a high dimentional (80 dimensions) vector space, based on what sorts of chords tend to be its close neighbors (within a 3 length window). This high dimentional embedding space is known to be well behaved, and notions of distance and relative position are quite robust. However, it is hard to visualize. So I used TSNE to put it onto a low dimentional space, so that you can understand which vectors are closer to one another.

Similarly, doc2vec embeds the whole MIDI file based on the overall distribution of its chords relative to other files.

Once the machine learning algorithm embedded the chords and files and placed them onto their respective surfaces, I had it output some data files that the frontend could read. I allowed users to click on this frontend to play the song or chord to see if they agree that neighboring points are similar. I also allowed them to see if relationships between the chords made sense. Below is the deployed visualization, trained on and displaying the free [midiworld](https://www.midiworld.com/) dataset.

* [Chord visualization link](https://midiworld-display.s3.us-west-2.amazonaws.com/words/display_template.html)
* [File visualization](https://midiworld-display.s3.us-west-2.amazonaws.com/docs/display_template.html)

Full code for the project [here](https://github.com/benblack769/midi_viewer)


After this visualization, I was disturbed by the low quality of the document associations (though some of the chord similarities are interesting). I blamed throwing out the durations and volumes, and I could not figure out a better way to preprocess the MIDI file, other than just to have it generate the actual audio. So I started insisting that only true raw audio, not MIDI files, should be processed in order for this analysis to be sufficiently general. That insistence led to one of my most successful projects ever, the sound-eval project ([project post here](/posts/projects/sound-eval/)). I was even able to reuse a lot of my visualization code there, and improve upon it.

### Graphical Notes

When I first started studying reinforcement learning, I ran across the [AlphaStar paper](https://www.nature.com/articles/s41586-019-1724-z). This paper is a huge, complex algorithm that took many of the innovations of deep reinforcement learning and putting them all together. However, I was unfamiliar with the literature and had a hard time organizing my thoughts as I was going through related work. I realized that the relationships between papers was not hierarchical, and so no normal organization system could help me compile my notes. So I decided to build my own note system, with arbitrary relationships, a visualization of those relationships, and also long form detailed notes as well as short-form descriptions.

The goal was not to have a super user friendly note taking system, but rather a note organization system, where you can visually understand whether your notes are connected satisfactorily, so that you know that the connections in your head, and the connections on paper are the same. So I built a command line tool that processes a yaml file with the note bullets and relations, and well as supplementary files and data for long form notes. This command line tool outputs the HTML and SVG data to make a static website.

While this seems like a clunky website architecture, it is fast, reliable, and easy to deploy. You can explore my reinforcement learning notes below:

[Reinforcement learning notes](https://benblack769.github.io/link_only/reinforce_multid_out/#alphastar)

While I rarely refer to these notes, the process of creating all these relationships is enormously helpful, as it forces me to enumerate all the relationships I know about a topic, and greatly increases my confidence that I understand a subject. While I won't recommend my tool specifically, as it is a bit clunky, I strongly suggest you try to take notes in a system which encourages you to make arbitrary links between thoughts. 

Full code to generate the static website [here](https://benblack769.github.io/link_only/reinforce_multid_out/#alphastar)











.
