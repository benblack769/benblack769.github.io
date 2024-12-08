---
title: "Graphical note generator"
slug: geneology
under_construction: false
excerpt: "An effective study tool for complex interconnected subjects."
comments: false
share: false
post_date: "2020"
img: /images/applets/graph_notes.svg
---



When I first started studying reinforcement learning, I ran across the [AlphaStar paper](https://www.nature.com/articles/s41586-019-1724-z). This paper is a huge, complex algorithm that took many of the innovations of deep reinforcement learning and putting them all together. However, I was unfamiliar with the literature and had a hard time organizing my thoughts as I was going through related work. I realized that the relationships between papers was not hierarchical, and so no normal organization system could help me compile my notes. So I decided to build my own note system, with arbitrary relationships, a visualization of those relationships, and also long form detailed notes as well as short-form descriptions.

The goal was not to have a super user friendly note taking system, but rather a note organization system, where you can visually understand whether your notes are connected satisfactorily, so that you know that the connections in your head, and the connections on paper are the same. So I built a command line tool that processes a yaml file with the note bullets and relations, and well as supplementary files and data for long form notes. This command line tool outputs the HTML and SVG data to make a static website.

While this seems like a clunky website architecture, it is fast, reliable, and easy to deploy. You can explore my reinforcement learning notes below:

[Reinforcement learning notes](https://benblack769.github.io/link_only/reinforce_multid_out/#alphastar)

While I rarely refer to these notes, the process of creating all these relationships is enormously helpful, as it forces me to enumerate all the relationships I know about a topic, and greatly increases my confidence that I understand a subject. While I won't recommend my tool specifically, as it is a bit clunky, I strongly suggest you try to take notes in a system which encourages you to make arbitrary links between thoughts.

Full code to generate the static website [here](https://benblack769.github.io/link_only/reinforce_multid_out/#alphastar)
