---
title: "Hyper-parental genealogy generator"
slug: geneology
under_construction: false
excerpt: "Visualizing trait inheritance with more than two parents."
comments: false
share: false
post_date: "2018"
img: /images/applets/geneology.svg
---

### Genealogy generator

I was working for [Marc Bedau](https://people.reed.edu/~mab/), a Philosophy professor at Reed College who was working with scientists to understand the deep nature of real work problems. The problem he was interested in at the time was patents. Given that new patents emerge from old ones, what does that genealogy tree look like? What characteristics does it have? Are there any patterns? Can we visualize it effectively?

One of the necessary steps is simply being able to work with hyper-parental trees (genealogy trees where a child can have more than 2 parents), and understand the dynamics of how inheritable traits tend to change under simple assumptions. Previous work had studied how single traits change, but not how multiple traits change. So I made an interactive web-app to allow my professor to easily click around and understand this multi-trait behavior through manual interaction.

The frontend simply makes a call to an AWS lambda service, which calls the legacy python code and the graphvis tool to generate the visualization.

If you are curious, you can see the application below. Note that it isn't obvious, but each row in the plot represents a different generation. That is, earlier generations give birth to a new one, in a new row, of the same size (remember, this represents patents, not biology).

#### [Genealogy generator](/link_only/aws_lambda_client/graph.html)
[![screenshot](/images/applets/geneology.svg)](/link_only/aws_lambda_client/graph.html)
