---
title: Generic Labeling for Task-Agnostic Models
under_construction: true
excerpt: "Philosophy behind task-agnostic labeling and labeling strategies to train them."
comments: false
share: false
img: ""
post_date: "2025"
priority: 1
---

* Data Generalization -> Task generalization
    * Regular ML focuses on generalizing across data sources. Different inputs, same outputs. I.e. detecting a car whether it is facing forwards or backwards, if it is daytime or nighttime.
    * Foundation models extend this to generalize across tasks. I.e. different people using the same model for different real-life purposes. I.e. using a chatbot to write a paper or to write code.

### Generic labeling

Get the machine to learn only part of the problem of interest, so that it generalizes better across many tasks.

* Negative labels
    * Label all the uninteresting stuff, get back stuff that is not uninteresting, i.e. interesting stuff
    * Most real-world AI has "unusual" or "exceptional" case detection as its most important factor in actual deployment
        * Industrial QC
        * Medical screening
    * Subtyping is not very important, anomalies should just be escalated to an human, because if its a real problem, addressing the anomaly will be a creative challenge in itself anyways (fixing the machine in industrial QC, creating a treatment plan in medical diagnosis)
    * Sensitivity is very important, even a 1 in 10,000 anomaly is still a very serious problem, must pick up such a rare case with high precision.
    * Natural datasets not always sufficient. 
        * I.e. regional diseases (tropical parasites) or plant-specific industrial datasets may mean that even with millions of training examples in the natural dataset, very serious problems in other regions/plants/etc may not have any examples in your dataset.
        * Creative datasets (purchasing data/data from academic studies or other out of domain sets)
    * Deep learning methods not very effective at this: Using classical methods like OneClassSVM or IsolationForests combined with deep learning feature extractors is key
    * Even when it works, likely to return a ton of stuff on new domains
* Object-labeling
    * what is an object?
        * High internal coherence (removed parts removes some coherence or )
        * Low external coherence (can be moved around in the environment with little loss in coherence)
        * Counter-factual probabilities (how likely is it for an object to be separated from its parent)
            * Window of a car vs a random part of a door vs a whole car
            * Windows can be broken/removed/replaced by a solid door/etc
            * Part of a window cannot be easily used in counterfactuals
            * Humans have very good knowledge of counterfactuals
        * object vs orientation
            * Person vs person's arm
            * Arm can be in many orientations with respect to a person. 
            * A person together with an arm has more causal information than a person without an arm, plus a person. This extra information is the arm's orientation.
        * Object vs stuff
            * Stuff is highly partitionable, internally stuff can be shuffled around without the grouping losing any causal relations.
            * "Glass" is stuff as it remains the same when broken into more pieces or grouped together into larger piles
            * "Window" is object as it is no longer really a window when it is broken, its function and relation to its surroundings change when broken
    * Objectness not perfectly predefined and consistent between tasks (Car vs Car window) - must be disambiguated with annotations
        * "Segment anything" "segment some things" (an author on the paper told me not to expect good performance on out of domain data)
        * Improvements in data
            * MedSam
        * Improvements in disambiguation
            * ScribblePrompt
* Open-vocabulary image labeling
    * Could this text conceivably correspond in a functional way with some part of this image?
    * Many possible labels per image, many possible images per label.
        * At workflow time, must have some way to refine prompts, either by adding more text or more image labels (keypoint prompts, etc)
    * When handling parts of an image, should ideally also be object-aware (described above). I.e. objects/orientations encoded in the label with bounding boxes/keypoints/meshes
    * Localized training labels vs global training labels
        * Rely on bounding boxes and such

