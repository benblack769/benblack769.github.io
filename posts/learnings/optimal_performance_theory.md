---
title: Optimal performance theory
under_construction: true
excerpt: "."
comments: false
share: false
img: /images/backprop/diagram-svg/whole-backprop.pdf.svg
post_date: "2024"
priority: 1
---

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
