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

As a practitioner designing and implementing real intelligent  systems, the question often comes up how to best teach the machine what it needs to solve the problem we need to solve. In particular, I'll be discussing supervised learning regimes where label scarcity, low diversity of positive labels, sparse information, production data shift and other factors makes crafting a training dataset tricky and unpredictable. Many of the improvements in real world systems follow developments in data design rather than model design. We'll be reviewing these practical lessons in data design and how they relate to fundamental concepts.

## Introduction to Dataset Analysis

Concepts in model analysis, such as overfitting and underfitting are often discussed in machine learning. However, less well understood are the dataset-side equivalents of these: *overdetermined* and *underdetermined* datasets. I'll be discussing this dataset mis-behavior, how to identify it in your datasets, and quickly review some techniques to solve them

### Overdetermination

Overdetermination occurs when you have true data scarcity. That is, true examples are difficult or impossible to obtain in any reasonable variety, and so its hard to fit a function to the data even ignoring labeling challenges. 

Overdetermination often discussed in the domain of historical analysis. The idea is that when you have some historical trend, there are many possible independent variables, and very few data points. So many possible, reasonable, and well regularized functions fit the same points perfectly. However, most of them do not generalize to the future, and thus do not capture much real information. A good example is predicting the rise of obesity in the United States. There are hundreds of possible indicators, from food sources, mental health shifts, economics, demographic shifts, and very few data points: realistically a single slow moving curve which can be modeled very precisely with just 3 free parameters. 

![Obesity curve](/images/labeling/Obesity_in_the_United_States.svg)

This phenomona is not overfitting because it is not a model design problem, no possible model is capable of reliably fitting the data. Even careful human analysis often fails to fit these sorts of historical trends reliably. Neither can this be solved by collecting more variables to help predict the target data. It can only be solved by finding some way to get more data points.

#### Overdetermination in computer vision

In computer vision, overdeterminism is a bit less clear-cut as compared to historical analysis. We humans intuitively feel as though many computer vision problems are solvable with very few data points. An entomologist can see a single photograph of a rare species of beetle they have never seen before, and can be expected to do a decent job identifying new photographs of the beetle in the future. And so many people intuit that machine learning systems are able to accomplish a similar feat, learning complex functions from very few data points.

However, this intuition is a false intuition. The reality is that the entomologist was trained on hundreds of thousands of images of beetles, and millions of images of insects. Many of this training data has data known to improve self-supervised learning capabilities, including 3d orientation shifts, time-series frames of live insects, scientific articles about function body parts with detailed annotations, images with clean backgrounds, etc. 

![moving insect (https://commons.wikimedia.org/wiki/File:Moschusbock_-_animated.gif)](/images/labeling/Moschusbock_-_animated.gif)

![pinboard (https://www.coffeewithus3.com/diy-bug-board/)](/images/labeling/Hoppers.jpg)

![scientific image (https://lizzieharper.co.uk/2015/01/natural-history-illustration-insect-anatomy/)](/images/labeling/bug-science.png)

This additional context gives powerful ground truth information about the relevant identifying visual information when examining a new type of beetle. Knowledge learned regarding one species generalizes to others, and gets extensively utilized when learning new types of beetles. This prior knowledge is the secret sauce which allows the entomologist to focus in on only a few key identifying criteria, and use these few criteria to reduce the number of independent variables, and transform the beetle identification problem from an overdetermined problem with too many independent variables to a well determined problem with only a few. 

Modern deep learning has a variety of techniques to accomplish a similar feat. Models with carefully crafted inductive biases, cross-correlation loss to make a denser loss function (self-supervised learning), fine-tuning regimes to utilize larger related datasets, various augmentation schemes to generate more diverse image-label pairs, and more. 

However, no current technique comes very close to matching the data efficiency of human domain experts. And so we do have to treat our datasets with the same care we treat overdetermined datasets in historical analysis, finding ways to make sure the model is learning causal, generlizable information regardless of dataset size or lack of diversity.

#### Identifying Overdetermination

Overdetermination is generally discovered from failures to generalize across 

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



### Underdetermination

Underdetermination is the the opposite failure case, where you have many data points, and few independent variables to use to predict them. A good example in computer vision is trying to predict car velocities from a single photograph frame.

![Highway photo](/images/labeling/highway-speeds.webp)

While rough estimates of velocity are possible (basing the guess on other context such as average highway driving speed in that part of the world), it is not generally possible to get precise estimates without at least two photographs at known points in time. For example in the gif below, it is very possible to get accurate estimates of speed, if you know the exact time difference between each frame, and using known reference points such as the length of dotted lines on the highway the cars are driving across.

![Highway gif](/images/labeling/Auf_der_Autobahn2.gif)

Bringing this back to the deep learning setting, no matter how high capacity a model you had, no matter how much labeled data you had, if you only have static frames as inputs, you will never expect your model to perform well on the data, because the data is *underdetermined*. The information you need is simply not present in the image. 

This underdeterminism of the static images is true despite a ton of information being present on the image. Lots of information is not a strong sign of having lots of relevant information. In the ML community, people sometimes assuming that there the algorithm can pick up relevant features even if humans experts can't. This is a dangerous assumption, as ML algorithms are very good at picking up on population statistics and making good estimates for underdetermined variables. But without clear, causal information in the source data, these guesses will never generalize across datasets with different population statics. There should always be some argument why true, causal signal for the target label is somewhere in the image.

#### Human expert estimations of underdeterminism

The good news is that expert human understanding of underdeterminism is usually very good. Very few projects predicated on the opposite assumption of human fallibility succeed. But just to address this more thoroughly, I'll discuss a few of these rare cases where they do succeed or seem to succeed but in fact don't and explain the circumstances to look out for.

The main case where human experts fail to recognize solid causal information in source data is when they were never trained on the particular data sources. This could be because

1. The image source is from a novel detector, and the expert and machine learning algorithm are learning from the same small set of labels as each other. 
2. The expert has simply not been trained on this data source, i.e. they just work in a nearby field, they are not a real expert.
3. The image data is in a raw format that is not easily readable to a human: i.e. raw ultrasound data (before processing/spatial mapping).

The failure cases which the ML algorithm seems to learn the thing judged to be underdetermined, but really  

1. The ML algorithm is simply more comfortable guessing with partial information and context clues which give population level signals. This is the aforementioned case which ends up being unreproducible as the ML algorithm isn't really looking at clean diagnostic information, and its performance will depend heavily on multivariate population statistics/correlations in their test dataset. 
2. Differing incentives between real world and ML, i.e. when an ML algorithm reaches 80% recall and 90% precision, which sounds good in a research paper, but a human will never make a positive call unless they are 98% certain, as in a high volume screening cases where high precision is absolutely necessary.

#### Detecting underdeterminism

Underdeterminism can lead to a variety of model-time failures. Human expert judgement is the most specific way to identify underdeterminism. However, if this is not avaliable, then some of the other indicators are:

1. Persistent train-val performance gap, even when model capacity is high. 
2. More data and better labels do not help with training.


#### Mitigating underdetermined datasets

Underdetermined datasets can be solved by several strategies

1. If known context was removed, simply add it back as needed. For example, if scanners give different looking images, instead of training one model that treats the scanners identically, the scanner type can be added as an input to give the model that additional context. 
2. If guessing is unavoidable and necessary, then try to make sure the model makes the best tradeoffs. Changes to dataset distribution through selective sampling or loss function changes are possible. It is also possible to modify probabilities after training completes to encourage the model to make certain tradeoffs biased towards the more common situation or the safer option. 
3. If guessing is unavoidable, make sure you are using appropriate regularization and augmentation techniques to avoid problematic overfitting on irrelevant details. Augmentations/regularizations need to be carefully chosen to ensure that the relevant details are preserved, and irrelevant details removed as much as possible. "Light" augmentations such as small color shifts cannot be expected to work well on underdetermined data, as the model will still try to overfit on irrelevant details. 
4. Label smoothing. Since the label information isn't fully present in the source data, the predicted label should not attempt to reach high accuracies nor should punish somewhat inaccurate predictions too much.

Underdeterminism is often caused by bad pre-processing or data design choices. For example, when an input video is partitioned down to individual still images prior to labeling or model training, information about relative velocities of objects are simply lost. Or when an image is cropped so that only part of the image is visible, then you can still make a good guess as to high level image information (its taken in a city) but might lose detailed information (which model/make/year of the car is centered in the photo).


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




Before ~2014, most analysis of machine learning systems focused on modeling decisions, and their resulting problematic underfitting or overfitting behaviors. However, with deep learning the models become so powerful that they can fit to any dataset, and the structure and problems of the dataset starts to matter much more than the structure and problems of the model. In particular,

1. Underfitting becomes less relevant because the expressive power of deep neural networks is simply immense, and its sometimes hard to even contrive functions which cannot be learned in practice, as even datasets of tens of thousands of images with completely random target labels can be memorized with 100% training set accuracies with out of the box learning regimes. 
2. Overfitting becomes less relevant because of the double-dip phenomena, that suggests that empirically, these same very overparameterized deep learning models which allow fitting very complex functions to very complex datasets also make learning simple functions on simple datasets easier.  This behavior is of course tied to random initialization and good inductive biases and other specific characteristics of neural networks, and is not a general characteristic of large models.


Of course, modeling decisions are still important: functional window sizes, inductive biases, model capacity, and other model characteristics are extremely important in training good models. However, practitioners are increasingly presented with very solid solution templates to guide them through these decisions and tradeoffs rather than having to find novel solutions with every new problem, as they had to in the past. 


