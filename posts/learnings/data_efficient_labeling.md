---
title: Practical labeling theory for computer vision
under_construction: true
excerpt: "."
comments: false
share: false
img: /images/labeling/bug-science.png
post_date: "2024"
priority: 1
---


As a practitioner designing and implementing real intelligent  systems, the question often comes up how to best teach the machine what it needs to solve the problem we need to solve, i.e. crafting efficient and effective dataset from the perhaps limited data you have. In particular, I'll be discussing supervised learning regimes where label scarcity, low diversity of positive labels, sparse information, production data shift and other factors makes crafting a training dataset tricky and unpredictable. Many of the improvements in real world systems follow developments in data design rather than model design. In this first post in this series, we'll be reviewing the fundamental theory behind these practical lessons in data designs.

### Negative labeling

* Most real-world AI has "unusual" or "exceptional" case detection as its most important factor in actual deployment
    * Industrial QC
    * Medical screening
* Subtyping is not very important, anomalies should just be escalated to an human, because if its a real problem, addressing the anomaly will be a creative challenge in itself anyways (fixing the machine in industrial QC, creating a treatment plan in medical diagnosis)
* Sensitivity is very important, even a 1 in 10,000 anomaly is still a very serious problem, must pick up such a rare case with high precision.
* Natural datasets not always sufficient. 
    * I.e. regional diseases (tropical parasites) or plant-specific industrial datasets may mean that even with millions of training examples in the natural dataset, very serious problems in other regions/plants/etc may not have any examples in your dataset.
    * Creative datasets (purchasing data/data from academic studies or other out of domain sets)
* Decision boundary theory of AI
    * Positive labels on one side, negative on the other
    * High dimensional space means complex boundaries are possible (100 dimensional space means decision boundary is a 99 dimensional hyperplane)
    * Deep neural networks have millions of dimensions, a measure of the decision boundary complexity, allowing extremely complex boundary conditions
        * If few positive examples, then overfitting is very likely, will miss some out of domain true positives with very high confidence.
        * Some tricks to mitigate this
            * Don't label visually similar negatives (tricky judgement call)
        * Explicit Regularization
        * Implicit regularization
        * Deep learning just works best with balanced datasets, but can solve this with above tricks to some degree
* Pretrained feature engines to the rescue
    * Supervised
        * Bottleneck hypothesis
        * Needs a strictly harder task than the downstream task (otherwise model will throw away distinguishing features which are useful to downstream task)
    * Self-supervised
        * Learn as much as possible about image's internal structure (cross-correlations)
        * Lots of progress, DinoV2
        * Visual similarity scoring (scene typing)
    * Much simpler decision boundaries can be effective for screening (hundreds of dimensions, simple linear structures)
        * Linear models
        * Random forests

### Generic labeling

Get the machine to learn only part of the problem of interest, so that it generalizes better across many tasks.

* Negative labels
    * Label all the uninteresting stuff, get back interesting stuff
    * Likely to return everything on new domains
* Object-labeling
    * what is an object?
        * Counter-factual probabilities (how likely is it for an object to be separated from its parent)
            * Window of a car vs a random part of a door vs a whole car
            * Windows can be broken/removed/replaced by a solid door/etc
            * Part of a window cannot be easily used in counterfactuals
            * Humans have very good knowledge of counterfactuals
        * object vs orientation
            * Person vs person's arm
            * Arm can be in many orientations with respect to a person
    * Requires user to disambiguate through interaction
        * "Segment anything" "segment some things" (an author on the paper told me not to expect good performance on out of domain data)
        * Improvements in data
            * MedSam
        * Improvements in disambiguation
            * ScribblePrompt
* Text-based image labeling
    * How likely that this text corresponds with this image (or parts of the image)?
    * When handling parts of an image, should ideally also be object/counterfactual-aware (described above)
    * Localized training labels vs global training labels
        * Rely on 
    * Various tuning to focus more on image-image correspondence (objectness/described above), yeilding possible hallucinations or image-text correspondence, yielding possible signal noise, which could be distracting or requiring additional filters
* Image-based text labeling
    * Give me an image, output text
    * Spatial models vs generative models
        * When asked to generate text, spatial models can only process fixed number of proposals
            * Dictionary of words/phrases
        * In generative models, text-text coherence matters more than image-text correspondence, much more likely to say something abstractly true but unrelated to the image than guess

### In the wild labeling

* Report/image cross-correlations
* patient metadata/image cross-correlations


