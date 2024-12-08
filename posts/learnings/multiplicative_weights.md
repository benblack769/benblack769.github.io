---
title: "Multiplicative Weights for Stock estimation"
slug: web-applets
under_construction: false
excerpt: "Also: why simple heuristics don't predict stock price changes."
comments: false
share: false
post_date: "2017"
img: /images/applets/multiplicative_weights_accuracy.PNG
---

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
