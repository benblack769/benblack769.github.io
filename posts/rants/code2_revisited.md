---
title: "Code 2.0 revisited"
slug: code-20-revisited
under_construction: false
excerpt: "The dream of Code 2.0 is only starting to be realized. "
comments: false
share: false
post_date: "2024"
---

### Code 2.0

Back in 2017, Andrej Karpathy wrote [an essay titled Software 2.0](https://karpathy.medium.com/software-2-0-a64152b37c35) about how Deep Neural Networks are empowering a shift from building software from code to building software with data. In particular, when giving meaningful semantic interpretations to raw data coming in from the real world. Inspirational problems include:

1. Industrial production quality control: is this image of a good product or a faulty product?
2. Digital diagnosis: Is this patient healthy, and if not, what is wrong with them? Where is the anomalous issue on the large/detailed scan?
3. Agricultural optimization: Do these plants need more or less water/fertilizer? 
4. Routine Infrastructure Inspections: Do these pipes/cables/etc have cracks/faults that are worth looking into more deeply?

Joy, excitement, tension, uncertainty, is what I feel when I read this list as a computer scientist. The tension between my desire to aid my fellow man by automating low-value, high volume analysis of our modern industrial landscape, and the huge difficulty of building robust software that actually solves the problems well enough to trust. It also brings up a little bit of trauma from when I almost failed a classical computer vision course in grad school.

Code 2.0 offers a solution to this anxiety: I, as a computer scientist, don't have to run the show. I don't have to reason about every detail of the algorithm. I don't have to customize or tweak everything to the details of my issue. Rather, I can take a supportive secondary role where I provide the infrastructure that ingests and trains a model on the algorithm and someone else can worry about the details, by developing the data, and ensuring that the data is actually sufficient to solve the problem. 

Its very similar to how a hardware developer, after the code 1.0 transformation caused by the development of the microchip, no longer has to drive every detail of the hardware's behavior. Instead, when confronted with a novel problem, they focus on assembling a platform, mostly from ready-made components, and simply ensure that the specs and configuration allows the software to do what it needs to do, without worrying about the details of how the software works or how it is developed.

### Barriers to Code 2.0 development

Code 2.0 has several barriers to implementation, the biggest being:

1. Projects are still driven by computer scientists, accustomed to a code 1.0 workflow, especially in the U.S. (China's businesses are much better about this). This means that data development has a waterfall workflow where large amounts of data is collected/cleaned according to some fixed scheme whereas algorithms are developed in a fast-iteration agile workflow. Which limits the amount of creativity and experimentation with data development.
2. Downstream and upstream challenges in edge hardware, networking, database integration, human review processes, business logic, and sales are often much higher than machine learning challenges, meaning that improving machine learning processes are treated as a second class problem.

The second issue doesn't have easy answers, but over time gets less important as the rest of the system matures. But the first issue is mainly driven by the ignorance and ego of computer scientists, and that is what I'm hoping to fix today.

### Code 2.0 in practice

In 2022, I joined a fascinating mid-stage startup that checked all the boxes. It did automated analysis of raw real world data, it had a real business model, and it was run by good, pragmatic people.
