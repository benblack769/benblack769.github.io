---
title: Practical labeling theory for workflow AI
under_construction: true
excerpt: "."
comments: false
share: false
img: /images/backprop/diagram-svg/whole-backprop.pdf.svg
post_date: "2024"
priority: 1
---

As a practitioner designing and implementing real intelligent  systems, the question often comes up how to best teach the machine what it needs to solve the problem we need to solve. In particular, label scarcity, low diversity of positive labels, sparse information, and other factors makes overfitting an inevitable consequence of simplistic labeling and training strategies. Here, I will talk about fundamental  ideas concerning intelligence and how they relate to advanced tricks practitioners have been developing to train more robust, practical models.


### Optimal performance theory

In the world of "physical AI", people care about much more about completing the task reliably than any signs of actual intelligence. This can be seen by the relabeling of "AI" into "expert systems" as they become more integrated into the real world: chess "AI" rebranded itself as chess "engines", "AI-driven medicine" turned into "digital diagnostics","self-driving" car companies systematically stripped the "intelligence" label from their advertisements, focusing instead on experience and absolute performance ([Waymo](https://waymo.com/intl/es/), [Tesla](https://www.tesla.com/ownersmanual/modely/en_us/GUID-2CB60804-9CEA-4F4B-8B04-09B991368DC5.html), [Ford](https://www.ford.com/technology/bluecruise/), etc), etc. Note that this relabeling happens without any change to the underlying algorithm or methodology. The "intelligence" part is dropped because simply because solid, reliable systems are preferred in the market to adaptive but unreliable systems. So its worth discussing any physical AI project in this expert system framework.

Expert systems are typically evaluated in the framework of optimal performance. This "optimal performance" skyline is ideally grounded by consequential factual results: the chess engine won at the end of the game, the car reached its destination safely, the patient did in fact have the disease after further confirmation, etc. Unfortunately factual results are always noisy: Maybe the car only reached its destination safely because other cars swerved out of the way to avoid colliding. And the results are generally very sparse: The car trip took significant time, expense, and energy, especially if it goes badly. The patient's disease might need to progress adversely to confirm its subtype definitively. This means that end results are only used in practice for evaluating expert systems at the very end of development, right before a general public release.

For faster evaluation, proxy evaluations are used give a faster, but biased evaluations. If all proxy evaluations are learned automatically from the consequential results, then the learning process is referred to as "end to end" learning. This concept is important in systems attempting to reach superhuman performance (i.e. AlphaGo). However, end to end learning is rare in practice, since humans have very useful counterfactual understandings of causal chains that are not easily inferred from factual results. For example, its hard for end-to-end self-driving systems to evaluate the true consequences of veering into oncoming traffic since, there are so few recorded factual examples of such an action. But humans can comprehend the consequences of this situation very easily from any given position.

Outside of simulations, almost all proxy metrics are defined by a dataset of input-objective pairs. This objective can be defined at a higher level "the robotic arm picked up the right object" or a lower level "the vision component of the robotic arm identified where the right object was relative to the pixels on the screen".

After the deep learning revolution, proxy metrics have almost always taken the form of labeled datasets:

* Ground truth optimal function from images to results for all possible images (human callable)
    * Infinite datasets of all possible looks
* Training Dataset (subset of the above, but could have false labels as noise)
    * Finite dataset with finite looks (and small in some cases)
* Finite machine can achieve perfection on this infinite problem if 
    * Outputs are fully determined by inputs
    * Problem is decidable (not turing complete)
* Supervised learning
    * Proxy loss: define loss function behavior on concrete examples
    * Loss function itself might be a proxy, rather than the target loss
        * Localization when not required
    * In principle, any model has the same sorts of problems if it performs well, including parametric models (deep learning) and non-parametric models (semantic search)

#### Dataset analysis over Model analysis

Before ~2014, most analysis of machine learning systems focused on modeling decisions, and their resulting problematic underfitting or overfitting behaviors. However, with deep learning the models become so powerful that they can fit to any dataset, and the structure and problems of the dataset starts to matter much more than the structure and problems of the model. In particular,

1. Underfitting becomes less relevant because the expressive power of deep neural networks is simply immense, and its sometimes hard to even contrive functions which cannot be learned in practice, as even datasets of tens of thousands of images with completely random target labels can be memorized with 100% training set accuracies with out of the box learning regimes. 
2. Overfitting becomes less relevant because of the double-dip phenomena, that suggests that empirically, these same very overparameterized deep learning models which allow fitting very complex functions to very complex datasets also make learning simple functions on simple datasets easier.  This behavior is of course tied to random initialization and good inductive biases and other specific characteristics of neural networks, and is not a general characteristic of large models.

Of course, modeling decisions are still important: functional window sizes, inductive biases, and other model characteristics are extremely important in training good models. However, practitioners are increasingly presented with very solid solution templates to guide them through these decisions and tradeoffs rather than having to find novel solutions with every new problem, as they had to in the past. 

But in practice, its worth putting much more emphasis on dataset decisions as these decisions end up driving overfitting and underfitting in practice by either maximizing the benefits of implicit regularization or maximizing the harms that come from problematic overfitting that networks can still perform.

When discussing datasets though, overfitting and underfitting are ill defined issues, instead, we call the corresponding phenomena underdeterminism and overdeterminism.

#### Underdeterminism

The first major failure case of proxy metrics is when they do not contain sufficient context to solve the problem perfectly, in such a way that no amount of intelligence can infer this missing information. This can happen for very difficult problems where there is simply no optimal solution to be found. I.e. I once had an x-ray done of a suspected stress fracture, and the radiologist told me it was impossible to determine whether the fracture existed or not from the x-ray: we would have to get another one done after it started healing to be sure (when stress fractures heal, they create clear lines of denser bone along the fracture lines). The information simply wasn't present in the image: no model could reliably predict the true condition. 

However, underdeterminism more also frequently caused by intentional dataset design choices. For example, when an input video is partitioned down to individual still images prior to labeling or model training, information about relative velocities of objects are simply lost. No function can perfectly guess velocities on arbitrary natural scenes given this limited information. Of course, in many cases, good guesses can be made from various bits of prior knowledge: i.e. a human in the middle of a walking stride has a fairly predictable velocity. But the information has to be guessed, and its just impossible to be as precise  as when frame-to-frame context is present (think predicting car velocity along a freeway down to 1MPH precision).

##### Detecting underdeterminism

In the deep learning regime, underdetermined datasets almost always lead some degree of model overfitting. Thus they can often be detected with train-val performance gaps. 

##### Mitigating underdetermined datasets

Underdetermined datasets can be solved by several strategies

1. If known context was removed, simply add it back as needed. For example, if scanners give different looking images, instead of training one model that treats the scanners identically, the scanner type can be added as an input to give the model that additional context.
2. If guessing is unavoidable necessary, then try to make sure the model makes the best tradeoffs. Changes to dataset distribution through selective sampling or loss function changes are possible. It is also possible to modify probabilities after training completes to encourage the model to make certain tradeoffs biased towards the more common situation or the safer option. 

When an expert system project starts bottlenecking on performance due to underdeterminism, it is advisable to start adding back the removed context and using more complex and powerful models. I.e. a 3d convolution over just a few frames of a video can capture velocity information that simply was not present on a single still image.

* Underdeterminism
    * Insufficient information to make a call, using context to make calls  
        * We have processes not to do this, but customers judge us on ability to make contextual calls because that is what they are doing 
    * No possible learnable function that can do well on both training + val sets
        * Gap between train and val sets
    * Context required to reconstruct ground truth label
        * Pramana's gram negative bacteria look like Hama's gram positive bacteria
    * Adding context
        * Scanner/collection/lab information
        * Patient information
            * Age/sex
            * Genetic information
    * Adding too much context can lead to problematic over-determinism (per-scan identifiers)
    * Optimal underdetermined tradeoffs
        * Loss function also very good at defining this tradeoff
        * After-training reweighting useful for this as well.
    * Label smoothing
    * Regularization
        * Details which lead to over-determination problems are high-density, useful information in other context, need explicit handholding to do better
        * Also why "light augmentation", or augmentation that does not remove useful detail in general cases does not work
* Overdetermism
    * Easy to label, hard to get examples of
        * HFW large eggs
        * Pap highest atypical cells
        * Macrophages 
    * Gap between training data and production data
    * Lots of very reasonable functions that do perfectly on training+holdout data but miss a bunch of prod data
    * Training images are often overdetermined (more possible discrimination boundaries than necessary)
        * Training scans are more-in-focus or higher quality than production scans
        * Generalization, overfit to one look, fail to pick up other looks despite common features between them
        * Sometimes certain details are very easy to pick up on, identify/compress the training dataset
            * Schistosoma
        * Resulting machine is too simple/incomplete
        * This extra quality is not always needed to pick up certain things (large HFW eggs/worms)
        * Lower quality production scans suffer in recall
    * "Heavy Augmentation"
        * "I know that this detail isn't needed, so I'll destroy the signal with noise" (blurs/180 color rotations, scales, etc)
        * We currently think we need a new model for every different set of heavy augmentation.
    * Learning algorithms (gradient descent) are not perfect at this compression,  one of the reasons large models are needed, is to help them be better

### Data efficiency hypothesis of intelligence

Intelligent beings understand a tremendous number of causes, consequences, and other associations with very limited experiences. This "data efficiency" characteristic is so critical to our understanding of intelligence that we judge each other's intelligence by it:

* A "gifted" student can learn faster, with fewer lessons and less practice than an average student.
* A "sharp" person is one who remembers some information when told only once, and can utilize that information right away in at least some capacity.
* A "genius" is one who can infer seemingly new knowledge without ever having learned it at all---i.e. generalize to seemingly fundamentally different areas of knowledge.

By contrast, characterizations such as "experienced", "expert", or "master of the craft", while certainly positive assessments of knowledge and effectiveness in a particular area, simply don't have connotations of general intelligence. Because they simply aren't good predictors of effectiveness in other areas.



* Why do overfit models seem less trustworthy than underfit models?
    * Same accuracy according to optimal function theory
    * Underfit models are usually interpretable
        * Dr Xu: "I understand why it made this mistake, its very understandable"
    * Overfit models are generally uninterpretable
        * Blank stares from reviewers, no possible human interpretation
* Dropping information
    * Translation engines based on language modeling prefer "fluency" (internal coherence) over "accuracy" (picking up every important detail in the source text).
* Hallucination
    * Making up new information that has high coherence with training data rather than with actual example


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




