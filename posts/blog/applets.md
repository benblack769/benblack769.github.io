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

[Stock multiplicative weights](https://benblack769.github.io/link_only/stock_vis/stock_vis.html)

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


### Genealogy generator


[Genealogy generator](https://benblack769.github.io/link_only/aws_lambda_client/graph.html)

### Sound Vector visualization


[sound eval](https://s3-us-west-2.amazonaws.com/fma-dataset-embeddings/display_template.html)

### Graphical Notes

[Reinforcement learning notes](https://benblack769.github.io/link_only/reinforce_multid_out/#exploration_exploitation)
