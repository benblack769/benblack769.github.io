---
title: "Visualize Everything: The Foundation of Machine Learning Aesthetics."
slug: ml-aesthetics
under_construction: true
excerpt: "Machine learning in practice always seems to end up ugly. Young ML leaders of the deep learning revolution emphasized one particular rule to keep their systems beautiful and inspiring."
comments: false
share: false
post_date: "2024"
---

Beauty in the crafts is not only a reliable indicator of whether something is heading in the right direction, beauty also causes improvements in the moral and productivity of practitioners, the confidence of those who direct them, the consistency of the eventual outcomes. Perhaps most importantly, beauty inspires and guides the next generation of students and apprentices.

Unfortunately, in most shops today, whether practically minded or academically minded, whether led by former physicists, former computer scientists, or former data wranglers, for one reason or another, machine learning ends up deeply Ugly. Is there any chance for practical, everyday machine learning in actual practice to be crafted beautifully, in a way that not only enhances the quality and consistency of the end product, but also inspires the people working on it and boosts the confidence of those directing the work? 

All work in all the crafts which produce objects should aspire to some sort of beauty, machine learning is no exception---but its beauty is of a different sort, and with different rules than the fields which many of its current leaders and practitioners migrated from.

### Why machine learning is ugly

Practical machine learning is widely regarded as objectively ugly (though effective) by most of the people who actually work with it. However, people from different backgrounds have different primary complaints.

* Unprincipled methods (mathematicians/physicists)
* Undebuggable, ugly code (computer scientists)
* Janky, fragile, untestable, slow systems (software engineers)
* Unpredictable performance (business leaders)
* Situation dependent quality (safety/regulators)

Progress cannot be made until acknowledging that none of these aesthetic or practical qualities can be addressed in the way they are typically addressed in their home fields. All known tools which work in those source fields consistently fail when applied to machine learning.

* Principled machine learning methods developed from strong statistical foundations with minimal assumptions produce far inferior models which are uncompetitive and unusable in the real world.
* Clean code techniques such as modularization and configuration inevitably decay into monstrosities with hundreds of configuration options and deeply broken abstractions when confronted with the needs of ML eperimentalists.
* Software engineers often use test framework that don't have GPU support, and even when they do, the expense of re-running full training runs at the (at least) daily frequency required by standard dev-ops practices can become huge. Also, the run-to-run variance of results, the combinatorial complexity of supported configuration options, etc, means that even big companies which invest heavily in dev-ops for machine learning struggle to get good automated test coverage.
* Business leaders want to be able to make decisions based on projections, before systems are built out. This is hard in machine learning due to the unpredictability of deep learning systems with their implicit biases, pretrained weights, inevitable enduring bugs, complex learning dynamics in generative learning regimes, etc. And, so typical analytical projection techniques used in business simply fail in machine learning due to there being no solid foundation to start applying any projection.
* The fact that all contemporary deep learning systems have adversarial examples leads to one big problem for safety/quality people: what about accidentally bad examples? What if someone's data is just out of domain enough that the predictions fail catastrophically? Unfortunately, there doesn't appear to be any great way to test for these out of domain examples---synthetic adversarial examples simply don't produce natural variation.

What does work then? The generation of young, unbiased innovators who became ML leaders during the deep learning revolution emphasis one rule, one ethic, one responsibility that ML developers must undertake to keep their systems beautiful:

> Visualize everything

> Now, suffering is a perfectly natural part of getting a neural network to work well, but it can be mitigated by being thorough, defensive, paranoid, and obsessed with visualizations of basically every possible thing --- Andrej Karpathy, [A recipie for training neural networks](https://karpathy.github.io/2019/04/25/recipe/)

> Log excessively.... In reinforcement learning, watching your system carefully means logging. Lots of logging. --- Andy L Jones, founder of RL Discord [RL Debugging](https://andyljones.com/posts/rl-debugging.html#tactics)

https://cs231n.stanford.edu/slides/2016/winter1516_lecture9.pdf

* Andrey Karpathy
    * 
    * https://karpathy.github.io/2014/08/03/quantifying-productivity/
    * https://karpathy.github.io/2015/05/21/rnn-effectiveness/
* Andy L Jones
    * Over 20 "required" metrics for monitoring the progress or RL systems
    * https://andyljones.com/posts/rl-debugging.html
* https://losslandscape.com/
    * Loss landscapes---art and science




In traditional systems software, which has some of the same problems, the clean code movement has proposed a particular solution: increased attention to making actual, working code concise, clear, and simple.

In machine learning, this approach fails, since data is equally important to code, and cannot be made arbitrarily concise as code can.

However, there is one emerging method 

Machine learning can be incredibly arduous. Huge data which are slow to process and difficult to review, feature based logic which defeats traditional debugging techniques, slow iteration requiring careful attention over days or weeks, endless low quality research literature which is exhausting to keep up to date on, bulky tools promising easy, out of the box quality for practitioners to tune ot their problem, but run into extensibility issues quickly.

Individuals from many older arts and sciences have attempted to tackle the challenges of ML by themselves, and are frequently defeated by one of these challenges that they find themselves unprepared for. Organized groups have been more successful at overcoming challenges through interdiciplinary cooperation.

To date, ML aethetics have been focused on one particular aspect of machi

* Mathematicians are often completely defeated by the unprincipled, but effective, practices of tuning machine learning systems. A rare few invent some new principled approach and work with practical engineers who bring it into practice.
* Physicists, who are trained similar to mathematicians, but have more appreciation for the pragmatic, have the same difficulty with unprincipled engineering, but typically endure it for longer; sometimes surviving for years under emotional strain, but never thriving. 
* Engineering


The traditional arts (medicine, gymnastics, religion) and crafts 

Business leaders, religious instructors, craft leaders and dynastic kings through the ages have emphasized a constant rule to building and maintaining any lasting craft, science, art, or body of knowledge: There must be an valid case to people's heart (ethics), minds (aesthetics), and bodies (reciprocation/payment). If any of these are missing, then complex, arduous crafts based on difficult science and maths are unsustainable, and fall into decay of various sorts. I.e. if there is no captivating aesthetics in a field, then young talent will look elsewhere to exercise their minds, and certain complex techniques will fall out of use, due to simple lack of anyone talented enough to execute them. The decline in the sophistication of wood-carving and stonemasonry during the European enlightenment is a great example. 

The role of Ethics in sustaining a craft is more complex. Sometimes, political forces destroy a craft out of a sense that it is evil, as in the destruction of the arts in China during the cultural revolution. Sometimes, people simply abandon an art out of disgust for what it stands for, notably the abandonment of violent sparing in traditional eastern martial arts, especially in the 20th century, in a switch to focus on gymnastic or mental aspects of the art, epitomized in the development of the pacifist Akido out of the militaristic Jujitsu in Japan. 

Right now, machine learning has a vigorous and still growing business backing promising vast bodily rewards, and a weakening, but still strong aesthetic promise of using psychological insights into our own learning to augment human intelligence and creativity via silicon processors in a way that mimics ourselves. 

However, machine learning is lacking a convincing ethical story, and various ethical spokesmen are accusing certain industry leaders of ritual cultic worship of transhuman symbols. While the evidence for this ritual cultism is unclear, the evidence for basic greed is not --- increasing emphasis on money above all in the field is increasingly disturbing, and is a sign of money attempting to replace ethics as a unifiying force.

However, lessons from history suggest this is deeply unsustainable. Unlike ordinary software development, advanced machine learning requires a deep cooperation between different groups to produce models in the real world. In expert systems, such as digital diagnosis, self-driving cars, legal document production, etc, the cooperation of thousands of practitioners is needed to 
