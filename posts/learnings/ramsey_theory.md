---
title: "Greedy Ramsey Theory"
slug: web-applets
under_construction: false
excerpt: "Investigating the nature of Ramsey lower bounds by visualizing the progress of a greedy algorithm."
comments: false
share: false
post_date: "2017"
img: /images/applets/ramsey.PNG
---

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
