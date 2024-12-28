---
title: "Human-powered Software 2.0"
slug: software-20-revisited
under_construction: false
excerpt: "The dream of Software 2.0 is only starting to be realized. A human-centric framework of successful data development teams is starting to emerge."
comments: false
share: false
post_date: "2024"
---

Back in 2017, Andrej Karpathy wrote [an essay titled Software 2.0](https://karpathy.medium.com/software-2-0-a64152b37c35) about how Deep Neural Networks are empowering a shift from building software from code to building software with data. This shift is now referred to more often as Software 2.0. In particular, when giving meaningful semantic interpretations to raw data coming in from the real world. Inspirational problems include:

1. Industrial production quality control: is this image of a good product or a faulty product?
2. Digital diagnosis: Is this patient healthy, and if not, what is wrong with them? Where is the anomalous issue on the large/detailed scan?
3. Agricultural optimization: Do these plants need more or less water/fertilizer? 
4. Routine Infrastructure Inspections: Do these pipes/cables/etc have cracks/faults that are worth looking into more deeply?

These simple semantic evaluation tasks are powerful on their own, and can drive quality control and efficiency in many important industries. However, that is not the limit of Software 2.0, as it can be enhanced with traditional algorithms for more complex planning and control tasks like:

1. Using high quality semantic positional evaluation to  efficiently search a game tree for optimal game play (AlphaGo)
2. Judging similarity between robotic position and human position for robotic imitation learning 
3. Judging design decisions for high level circuit-silicon block mapping for effective chip design.

These tasks have traditionally been extremely challenging to machine learning professionals, with professional histories often registering more failed or underperforming projects than successes. Aligned industries tend to be somewhat risk-adverse, attracting more risk-adverse professionals, operating in a conservative, incremental manner. Leading to an overall under-utilization of the Software 2.0 stack, despite the hype and perhaps over-utilization in a more risk-seeking "Tech" industry.

Software 2.0 offers a solution to this professional anxiety: I, as a computer scientist, don't have to run the show. I don't have to reason about every detail of the algorithm. I don't have to customize or tweak everything to the details of my issue. Rather, I can take a supportive secondary role where I build the platform and the infrastructure that ingests and trains a model on the algorithm and someone else can worry about the details, by developing the data, and ensuring that the data is actually sufficient to solve the problem. 

Its very similar to how a hardware developer, after the Software 1.0 transformation caused by the development of the microchip, no longer has to drive every detail of the hardware's behavior. Instead, when confronted with a novel problem, they focus on assembling a platform, mostly from ready-made components, and simply ensure that the specs and configuration allows the software to do what it needs to do, without worrying about the details of how the software works or how it is developed.

Industry leaders like [Andrew Ng](https://landing.ai/) have been championing this concept and starting startups with the hope of powering this Software 2.0 development with powerful training/inference platforms. However, understanding of the philosophy of this workflow is still poorly understood, leading to defaulting to more well understood, but slower and more wasteful Software 1.0 workflows based on static dataset collection.

## Barriers to Software 2.0 development

Software 2.0 has several barriers to implementation, the biggest being:

1. Projects are still driven by computer scientists, accustomed to a software 1.0 workflow, especially in the U.S. (China's businesses are better about this) This means that data development has a waterfall workflow where large amounts of data is collected/cleaned according to some fixed scheme whereas algorithms are developed in a fast-iteration agile workflow. Which limits the amount of creativity and experimentation with data development. 
2. Downstream and upstream challenges in edge hardware, networking, database integration, human review processes, business logic, and sales are often much higher than machine learning challenges, meaning that improving machine learning processes are treated as a second class problem.

The second issue tends to get easier over time as the rest of the system matures. But the first issue does not get solved by time, rather it is driven by computer scientists running the show. Below, I'll explain the principles involved in making someone else the center of Software 2.0 workflows.

# The Software 2.0 Team

In 2022, I joined a fascinating mid-stage startup that checked all the boxes. It did automated analysis of raw real world data, it had a real business model, and it was run by good, pragmatic people.

They built remarkably human Software 2.0 workflow, centering on the humans labeling the data, the Data Managers (this is not an inflated title, they really managed a lot, and a lot of project success depended on their skill). Unlike Software 1.0 workflows, where the labelers simply hand off the data at some point, at this company, the data managers iterated with product advisors to determine the best way to label the data, actually labeled the data, trained the model, used the model to find good labels to add, evaluated the model, built out metrics, advised studies, and more. The remarkable scope of their responsibilities meant that relatively little time was spent on actually labeling or reviewing data, maybe 40% of their time on average.

## The Software 2.0 Data Developer

The lead Data Manager, a very talented individual, but with no machine learning background or education, over time, developed a strong philosophy of the true human demands of data management which surpass any particular data labeling processes used per-application: 

1. **Product Understanding:** The Data Manager must have a strong grasp of the application/product, and the significance of model performance/characteristics on the end product. 
    * "Co-developer of the product specifications" is the ideal.
    * Background in fields nearby the target application is helpful
    * Independent research in best practices is useful 
2. **Data Understanding:** The Data Manager must have an broad intuitive understanding of their entire dataset---what different looks/domains there are, what distribution the training data has over these looks/domains. 
    * "Hold the entire dataset in your head" is the ideal. 
    * Various visualizations and reports are important to assist the human understanding, and become more important the larger the dataset is. Datasets in the thousands can be managed with basic tooling, data in hundreds of thousands needs highly specialized tooling.
3. **Model Understanding:** The Data Manager must have an understanding of how the model is actually behaving.
    * "Be able to guess the model's classification decision" is the ideal, allowing maximally good decision making of what to change.
    * Making simple, understandable, communicable data labeling decisions is the most important attribute here.
    * Regularly reviewing real model results by hand is an invaluable and irreplaceable tool.
    * Visualizations of the model's bottlenecking behavior (how it groups objects in feature space) has been also proved a useful tool to assist understanding of what features the model is struggling to distinguish between (usually caused by data labeling ambiguity only fixable by the data manager). 
    * Model tests, that is labeled tuning data held out from training will show any confusions between the DM's evaluation and the model's evaluation, allows quick identification of known issues.

These demanding requirements pave the way for a whole new skilled craft---the Software 2.0 data developer.

### Data Manager Process Focus

While all the above intellectual demands have an important place, there is clearly a much greater degree of mind-numbing grind in Software 2.0 development than Software 1.0 development. Combined with the high degree of responsibility and focus of understanding on the Data Manager, second guessing and decision exhaustion are huge problems. 

To minimize this second guessing and allow for the possibility of smooth flow in the labeling, targeted processes can be established to commit to workflows that are understood to work, and see changes through to where success can be determined. 

These processes will be a huge help to workflow efficiency and project timelines if well designed, and can stall a project if poorly designed. Thus, these processes should be large on the minds of anyone leading or directing such a project.

However, it is important that processes take a second-place role behind the human Data Manager and others heavily involved in the project. The quality of the people matter more than the quality of the processes.  Junior Data Managers can work with a more senior ones to help work through tricky issues and to get ideas of effective processes to solve those issues. However, we found that bringing in outside expertise more distantly connected to the project to try to establish processes consistently caused churn and poor results. Instead, regular review of the process with those heavily involved yields the most consistent results.

## The Software 2.0 Platform Developer

Software 2.0 is built ontop of Software 1.0, similarly to how Software 1.0 is built ontop of hardware. Which means that Software 2.0 still needs regular software developers to build the system that powers the Software 2.0 data management workflow above, help collect raw data from edge sources, and build out any inference pipelines in the application. The role of the Software 2.0 developer is to be a supportive engineering/data operations role that takes second-hurdle to the Data Manager. As this was my role, I identified a few principles which helped me be effective in this position:

1. **Minimize ML Configuration:** Data Managers are not machine learning experts, and struggle to understand the details of all the knobs that ML Engineers typically build into their platforms (learning rate, batch size, etc). The number of knobs that need tuning for best performance, the less effective the Data Manager will be. Good defaults, effective heuristics, and automated hyperparameter selection are key to keep DM workflows efficient.
2. **Inference pipeline/Evaluation pipeline equivalence:** The inference pipeline that the data manager uses to evaluate the model must be near-identical to the production inference pipeline. Otherwise, unexpected behavior in production is a big risk.
3. **Avoid lockin on pre-processing techniques:** Real world data often needs quite a bit of pre-processing to feed into an ML pipeline. Grabbing manageable subsets by cropping images, grabbing video/audio snippets, chopping up text into chunks, etc, is common. Compression pre-processing, such as generating audio spectrograms, static image/text embeddings with foundation models, etc, is also common. If your data labeling strategy locks you into the specific style of pre-processing, this can harm your ability to improve the system. These pre-processing choices have meaningful and significant impact on end performance. In my job, I made more end performance improvements tuning this pre-processing than any changes to loss function or architecture, and many other ML engineers have the same experience. Simply retaining the ability to re-generate these on demand is sufficient.
4. **The Cloud is best for Software 2.0 development workflows:** For Software 2.0 workflows, the best parts of the cloud are shows at their very finest. The cloud's fast scalability and ephemeral qualities are perfect for the very spiky Software 2.0 GPU hardware demands, and ephemeral nature of most intermediate training artifacts. However, its important to not lock into a inference provider---cloud, on-premise or edge inference are all important capabilities.

## The Software 2.0 Domain Specialist

Another key role is domain specialist, a true expert in the domain. This role is key to building a robust product which is useful in practice and trustworthy. This role helps gauge the scope of the model, offers criticism of the model's performance, and helping find difficult cases and identify failures. 

Generally speaking, this role needs to have the following philosophy in mind:

1. **Deep practical experience:** The specialist is ultimately the main arbiter of feature priorities. So they must understand the risk/reward benefits of every feature, which requires a deep experience and understanding of the industry.
2. **Distance from model development:** Sadly, whenever we collaborated with a specialist who knew a lot about machine learning from, reading, research, or academic projects, the project went much more slowly and painfully. The reason is that the specialist, out of curiosity, tends to and offer incorrect advice about what will work, what should be attempted, and other unnecessary meddling into the Data Management process which typically increased friction and reduced trust. One one person can truly own/lead the data development process, and that person needs to be in the data every day, following the image of the Data Manager above. Of course if this person happens to also be a specialist, that can work, but its rare to have true expertise in two fields.
3. **Education-Minded:** The domain specialist is an invaluable source of information for the other team members to learn about the details of the application. Having a teaching mindset is valuable for this purpose.


# Software 2.0 Practices 

The success of any project is most closely related to the quality and dedication of the team that does the work, including both individual qualities and team meshing. However, there is still benefit to learning from past successes and failures. In particular, properly reflective experiences yield a principles to evaluate future strategic and tactical approaches. This cohesion onto particular strategies, tactics, and individual roles can boost team cohesion. This section is dedicated to the principles we have learned generally succeed in a Software 2.0 approach. This analysis is not complete, nor free of errors, as it is dependent on the mistakes and choices we made in our approach.

To start, lets examine all the differences we found from best practices in Software 1.0 style machine learning.

## Software 1.0 vs 2.0

To emphasize the differences and changes one can expect from a Software 1.0 process to a Software 2.0 process, lets review the basic Software 1.0 development process.

1. Determine labeling strategy+classes
2. Label training+test dataset, the larger and cleaner the better
3. Determine metrics to evaluate model on
4. Iterate on model/learning strategy, attempting to improve metrics
5. Go back and review steps 1,2, and 3 if step 4 can't yield good enough results.

Meanwhile, the Software 2.0 process emphasizes data iteration over model iteration, so the main iteration loop is on the data, rather than the model, requiring a bit of a re-ordering of the steps to support this data iteration. 

1. Determine labeling strategy+classes
2. Determine model/learning strategy
3. Iterate on training dataset, evaluating model outcomes as one iterates
4. Determine metrics to judge final model on and create test set. (Typically implemented concurrently with step 3)  
5. Review steps 1, 2, and 3 if the model doesn't pass the bar.

The key insights that were discovered upon implementing this process in practice are: 

### De-Emphasis of Metrics in Software 2.0

The most surprising finding to an ML engineer is how *unimportant* metrics end up being in a Software 2.0 workflow. In Software 1.0, no solid progress on models can be made without solid metrics, so a dogmatic assertion of the field is that metrics development needs to come before model development, and any model development is constrained by the capabilities of the metrics to measure the true performance. Because otherwise, any changes are shots in the dark, and unlikely to hit their mark by random chance.

However, in Software 2.0, metrics are secondary. The reason is because the Data Manager is reviewing model results all day, every day, and they develop an intuition for model behavior independently of any metrics there may be. 

Furthermore, this experience-driven model understanding can often be *superior* in finesse to any metrics one might design in complex practical cases. If there are any downsides, it is that metrics look at a lot of data at once, vs a data management process that typically subsamples the data heavily during review. And of course, good metrics are easily communicable to outside groups, and experience-based intuitions are not. But at a strategic level, metrics can take a second tier of importance in a Software 2.0 world, can come later in development and can be of lower quality than the training data.

### De-Emphasis of Data Size in Software 2.0

The second surprising finding is how training data size becomes a mixed bag in human-centric Software 2.0 workflows, and keeping datasets small and highly curated can be the way to go. In Software 1.0 workflows, more data is always better. Models can get more, better feedback from more data, even if its quality is relatively low. Especially in cross-modal datasets, more data allows models to find rare associations that simply wouldn't be present in smaller datasets.

However, in human-centric Software 2.0, more data means more data to review for errors, more data to balance, more data to refactor if labeling strategy changes slightly. I.e. similar to how in Software 1.0, all code is a liability, and simplicity is key, in Software 2.0, all data is a liability, and simplicity is also key. 

How to reconcile this concept of data liabilities with the success of huge datasets, such as the 400 million image/text pairs to train CLIP, or the 1 billion masks used to train the SAM model? Or the hundreds of terabytes of raw text used to train LLMs? 

Its simple: those models were trained in a human-exploiting regime, rather than a human-centric regime. Human-exploiting regimes have an entirely distinct set of guiding principles that focus on the importance of a good architects to make good decisions at project inception, high quality "from the wild" data collection/filtering, and labeler arbitration routines to ensure consistency and cleanliness.

The fundamental issue with human-exploiting training strategies, and the real-world failure of these large datasets in building good semantic analysis engines, is the loss of control implied by giving the dataset construction over to a particular process. The process takes control, and starts pushing the dataset in unexpected directions in cases of fundamental ambiguities or data domain discrepancies. Interestingly, all of the datasets meant for "general computer vision" (Imagenet) or "general object detection" (COCO) or "general segmentation" (Segment Anything), all fail with even slightly out of domain data, and have much less value in the real world than first thought.

Interestingly, modern LLMs take an increasingly mixed approach, with an initial large-scale pretraining step focused on architecture and large-scale data, and also an increasingly human-centric RHFL fine-tuning stage, with much of the innovation in the field being identifying and fixing model biases with careful human expertise and attention, rather than large data. While the exact methods behind the most state of the art models is kept closed, it seems as if these reinforcement learning sets are kept relatively small, agile, with high-skill labelers. Dependency on hordes of unskilled data labelers is limited in such state of the art AI.

This hybrid fine-tuning approach looks increasingly like the trend for real-world machine learning in the next 5-10 years. However, its important to note that other domains have yet to build out the very clean fine-tuning workflows and concepts that have been built for LLMs, and attempts in other domains have not had as much success so far. Innovation will be important to proving the value of hybrid systems in practice.

### Re-Emphasis of data inspection/visualization tooling

As datasets become larger, the Data Manager's idea of "holding the dataset in their head" is no longer realistic. Rather, advanced tool use is required to analyze, understand, and control the larger set of artifacts. Some of the visualizations which proved exceptionally valuable are:

1. Presentations of the failure cases on the tuning or test set. Allows a quick review of the worse-performing identified examples. Especially useful if model performance suddenly gets worse during development.
2. A whole dataset infinite scroll view: Critical for manual filtering/review. Idea is to use the intuitive part of our brain to quickly look for easily identifiable qualities. Ideally, one should be able to review a few hundred images, or a few dozen text sentences in a few minutes. Clicking through examples is unacceptable, multiple examples need to be on the screen at the same time. Advanced filtering/sorting tooling and tagging schemes to structure this view become very important as datasets grow in complexity. 
3. Some visualization of the model's behavior at the feature-vector level. Either relative distance visualizations with a clustering visualization, or a PCA-style spatial dimensionality analysis, or both. Ideally, these visualizations are even interactive, and you can pull up individual data points and examine outliers in a unified workflow. 

Many more advanced and domain-specific tools are possible, these are just the essentials for any Software 2.0 workflow. 

Especially as tooling grows more advanced, substantial training and adaptation to the tool is needed. Ultimately, the human and the tools they use should greatly surpass the capabilities of any automated of either an fully automated or fully manual system, but this will require significant investment into true mastery of the technology, adapting to it as necessary. The ideal is a cyborg-like wholistic system, where the system prompts the human, and the human responds with solid, broad-based judgement.

### Continued emphasis on normal code debugging 

An quote on an OpenAI blog for a reinforcement learning project (can't find it) said "how did we improve performance? By fixing bugs. And how did we improve performance even more? By fixing more bugs".

Almost every problem in a principled, general purpose machine learning system looks like a bug, not a missing feature. Its seems like a bug when small objects get overlooked and aren't balanced in the loss compared to large objects. It seems like a bug when scenes fed to the neural network center every object perfectly. It seems like a bug when training data is broken apart into sentences when the inference data is a continuous stream. These types of "bugs" appear with similar frequency in Software 1.0 and 2.0 systems.

Isolating, and resolving these sorts of "bugs" ended up being much of the value we ML Platform developers added once our platforms reached a certain level of maturity. There seemed to be no real end to them. The reason is because this is just what normal ML platform development looks like in a Software 2.0 world---new features just look like bug fixes. And if you continue to push the limits of the system, the need for more and more of these fixes and tweaks will surface.

<!-- One tricky issue to watch out for, is that like any high-level software platform, bugs eventually become features, as people start to work around any issues they discover in a way that ends up depending on the issue itself, and their datasets or workflows end up depending on the issue, and so the user is actually harmed by the fix. Sometimes this is worked around by adding configuration in the short term, but in the long term, default settings need to all work as well as possible, and ideally, configuration that is never recommended for normal usage is slowly deprecated. -->

## Responsive Labeling Schemas

The first step in an ML process is to identify the semantic label schema. However, this labeling schema is too important, and course correction later in the project will inevitably be required for improvements in performance and utility. On the other hand, shorter-term commitments to particular labeling schemes is critical to ensure consistency and second-guessing anxiety. So making the best judgements possible at key junctures, and backing those commitments until the next juncture is a helpful pattern.

The importance of the careful creation of labels cannot be understated. Here are some examples where a subtle change in label definition radically changed the outcome of a project:

1. The Leela Chess Zero (Lc0) engine, originally an open source AlphaZero clone, started branching out in its goals. Where originally the project was all about establishing the best possible win/loss ratio against a strong opponent, with draws counting as neutral. So the labels were win=1, loss=-1, draw=0, modeled as different outcomes of a single variable. However, there was an increasing problem with draws: the engine often preferred drawn outcomes over risker, possibly lost outcomes. Not only does this drawish tendency lead to low performance in engine tournaments with weaker opponents, it also made human players question the utility of engine advice in worse positions and close endgames, where the engine's tendancy to draw might be at odds with the human's desire to win. Modeling the draw rate as a separate variable, learning to predict draw outcome consistently, and optimizing to reduce draws was [a huge challenge that took years of development](https://lczero.org/blog/2023/07/the-lc0-v0.30.0-wdl-rescale/contempt-implementation/) for the project to perfect. However, a fine-tuned version of Lc0 is now the [strongest engine ever against human grandmasters](https://lczero.org/blog/2024/11/fine-tuning-lc0-network-for-odds-games/), and this draw-score has also proven valuable in competitive chess engine tournaments.
2. In RLHF LLM training and general LLM evaluation, one interesting characteristic in human rating has been determined: humans consistently rate longer, more verbose results higher in quality than shorter, more concise results. These longer passages human raters prefer include caveats to certainty, various supporting facts/references for the judgement, reasoning, etc, that make a human judge the passage as more accurate and more reliable (even when the supporting facts are hallucinated). However, many different use-cases, this verbosity is not desirable: so you see a difference in human judgement in the labeling process, from human judgement in the real world. So the trend is to try to simulate various human usecases to condition the review/rating protocol, rather than relying on a single wholistic judgement of accuracy.
3. In our experience in object detection, we have seen radical change in performance from labeling part vs whole of an object. The reason seemed to be because whole objects were more unique than parts, and could be labeled more consistently, and have fewer confusions, yielding better results in both detection and confusion metrics.

Thus, even in modern machine learning with large, synthetic datasets, labeling and modeling choices are key drivers of end project success. These decisions are also critical in smaller, data-scarce projects. In our experience with data scarcity, the following labeling characteristics are very helpful:

1. **Distinguisability:** Clear distinction between classes/labels. This is helpful not only for the learning system to separate the classes, reducing the quantity of data required, but it is even more important for the sanity and efficiency of the human labeler. And even more important if labeling is done as a team, so that team members can review and come to agreement about all the labels.
2. **Descriptive Labeling:** Subtyping and descriptive labeling is helpful for the data manager to more easily reason about and organize their datasets. Whether the machine learning system ends up throwing this descriptive information away, or utilizing it to learn more about the environment, is less important. More important is the flexibility, understanding, and control that these descriptions offer, especially in cross-domain/source data. 
3. **Arbitration:** When clear and easily agreed upon distinctions/schemes are not possible to arrive at, or when ambiguous cases arise, there is a benefit to incorporating an arbitrary element: a certain bias or tendency of a head data manager. As an analogy, consider a team of animators working on a cartoon: there is a single artist responsible for the overall style, and the other animators need to conform to it---a mix of styles is unpleasant. In real world ML applications, when the standard of clear distinguisability is not met, this consistency created with a wholistic vision of model behavior is more valuable than any sort of artificial consistency imposed by some sort of multi-labeler consistency protocol. This value is revealed in behavior on ambiguous objects, where some particular model behavior, is more desirable than another based on how the model is used, and average accuracy scores are unimportant. I.e., if 99% specificity is required for the system to act autonomously, no one cares that you increased accuracy from 90% to 95%----it needs to be specific, and data manager arbitration is the most powerful tool to design datasets with the capability of reaching these high targets. 


## Active Learning Labeling Protocol

The central process of Software 2.0 (the bulk of the middle part of the project), that can start immediately after an initial labeling strategy is determined, is an "active learning" labeling/training loop. Active learning is when the current iteration of the model is used to more efficiently label and curate data for the next iteration of the model. 

At a basic level this loop improves labeling speed, because model predictions are often accurate, and can simply be verified. But we have found that the active learning loop can be much more than a labeling speed improvement, as model predictions allow data managers to understand what the model is already good at, and not add data which is already very high accuracy, resulting in smaller, easier to modify datasets. To explain in more detail, here is a high-level description of this training process:

1. Data Manager creates/loads starting dataset to train first iteration of a model (this starting dataset can be very small, i.e. dozens/hundreds of examples, if the hyperparamters are tuned for small data).
2. The model is trained on this dataset.
3. The model is used to predict labels on the raw, unlabeled training set.
4. The data manager reviews these labels, editing or rejecting proposals that are incorrect or duplicates, creating a new iteration of the dataset.
5. The model is retrained, going back to step 2.

To maximize the value of active learning processes, the following objectives should be kept in mind:

1. **Efficient Positivity Correction:** If the model's predictions are sorted by confidence, the Data manager can easily identify and correct model false positives and other positive errors, such as high-confidence sentence mis-translations. These errors can can be corrected in a data efficient manner by including the source data and corrected labels for the model mis-predictions only.
2. **Efficient Negative Correction:** In real-world data, most subtypes are rare, and must be purposefully sought out and collected for model training. However, these labels might be basic and not necessarily be included in the training set with precise labels. However, in the active learning loop, generated labels can be evaluated compared to these rough labels, and model misses and false negatives can be fixed and added to the training set. If you are unclear what is meant by rough labels, then refer to the below section on end to end evaluation.
3. **General Model Understanding:** The Data Manager should be gaining a general understanding of the model's behavior and how it responds to changes in data labels. While this general intuition is not a replacement for principled labeling strategies, this intuition brings a greater understanding of the data that is actually required to achieve goals, and ultimately, brings knowledge and insights to the team. 
4. **Minimal Datasets:** Focusing labeling on problematic cases should be shrinking the required dataset size and making datasets easier to review and modify, relative to a labeling protocol free of this feedback.

## End to End Evaluation

In Deep Learning, much hype is made about "End to End" learning, that is, a model that takes in raw data and outputs actions that drive a fully automated system, like a self-driving car. The benefit is that humans do not need to design the intermediate representations; these representations can be learned via backpropagation, and thus these representations can be much more informative and higher-dimensional than a human can visualize or review for accuracy.

In practice, end-to-end training is still impractical in many concrete applications, due to a lack of data, computational limitations, and optimization challenges (overfitting, instability, etc). In these systems, the low-dimensional, highly structured, human reviewable intermediate representations becomes an advantage which allows humans to identify and fix problems with the system. This results in a system with one or more independently trained components, such as a semantic vision system, audio processing, and perhaps certain complex control components, with the rest handled with more handcrafted logic. 

In such a mixed Software 1.0/2.0 system, it becomes important to evaluate whole system performance as best as possible. Whole system evaluation allows discovery of compounding failure cases, de-prioritization of issues when failures in one sub-system are corrected by another, and other cross-component concerns.

End to end evaluation is also practical much more often than end-to-end training, requiring much less data. It is also very valuable, as good understanding of these cross-component concerns end up being invaluable in making good decisions at key points during the development process, and so building out test sets is valuable, even if expensive.

### Special note on Human-in-the-loop systems

ML Inference systems that expect a human to review results comprehensively, for example in medical diagnosis, true "end to end" evaluation might involve a human re-reviewing the results. While this is important to evaluate, running this test clearly has a high marginal cost, as opposed to the high fixed cost of setting up a fully automated test.

Setting up permanent employees available to run these tests for the entire project duration is a good option, and is almost certainly necessary in the most complex projects (AlphaGo project had a professional Go player on staff to probe the AI for weaknesses, for example). 

However, another option that can allow for cheaper but imperfect end-to-end testing on simpler projects is to simulate the human with another model that is trained on human expert actions. While not perfect, and not always advisable, general trends in results are likely to correlate between real human experts and simulated human experts.

## Valuable Metrics

While metrics are less important in Software 2.0, as mentioned earlier they can still provide significant value when they can be used to improve the dataset or make key decisions. The key characteristics that make a good metric include:

1. **Traceable:** Regressions/changes in metrics are traceable to individual items in the test set that failed/changed. 
2. **Actionable:** The above trace can be used to make changes to the training set to allow for better results. Sometimes, this means hooking up this error tracing system to a dataset suitable for inclusion in training, so that identified errors can be included or up-weighted in training processes. (See above section on [active learning](#active-learning-labeling-protocol))
3. **Value-Aligned:** Metrics are most reliable if they reflect the true impact of error on the value of the end product, and not some artificial accuracy measure. Quite a bit of balancing/weighting might be necessary to achieve this value alignment. Some tools to align metrics include: grading errors on a multi-tier scale, up-weighting under-represented error cases in the test-set, or downsampling over-represented error-cases.

The benefits of these principles apply in both end-to-end evaluation, and in single component evaluation, however, tracing and acting on errors is harder in end-to-end evaluation, allowing single-component evaluation to shine.

# Software 2.0 Product

Developing Software 2.0 can be a difficult, expensive and slow operation to undertake, and the resulting product must be well targeted and highly valuable. In the end, all ML projects without a strong business case eventually fail. ML projects require significant maintenance, computer infrastructure, and support, and need durable sources of income to support operations. Given these costs, driving projects from the business side, and working backwards, can be a much smoother process than trying to find applications for novel ML technologies. In fact, the entire Software 2.0 paradigm is about paving smoother, more consistent paths to business automation success, depending more on team quality and commitment, and less on luck and timing with experimental technologies. 

While no complete guide on Software 2.0 products can be assembled, as there is limitless room for creativity and innovation, some decent principles for those just starting out in Software 2.0 are:

1. Make sure you are getting the best fruit, whether it is low-hanging or not. Sometimes, low-hanging fruit is actually not valuable enough to change anyone's behavior and not valuable enough to sell your product at any price. For example, outsider perceptions of value, and insider's perception of value in an industry can be shockingly different. Insiders recognize that one well-trained, well-suited human might be able to outperform 10 poorly trained humans. So if as an outsider, you try to evaluate the value of automating a poorly trained human, you will get a very different value proposition than the insider's perception of value given a highly trained human.
2. Make sure your product is not solvable with mathmatical approaches. Deterministic algorithsm and statistical methods are easier to implement, more reliable, and easier to understand. Sometimes difficult puzzles and challenges that seem impossible to solve perfectly, like NP complete problems like the famous traveling salesman problem, have very good heuristic approximations that actually outperform all data-centric methods, in all cases. Finding the right specialist to identify the best heuristic or statistical technique can be tricky, but the long-term reliability of principled algorithmic systems will make up for it eventually.
3. Make sure your problem does not add more burden to humans than it removes. Does the automation interrupt a previously smooth human workflow, by requiring data entry, application switching, or any other manual work that was previously unnecessary? If so, it can be harder to out-perform an expert human in the flow than you would think. These workflow issues may need to be resolved with hardware or software integrations before your Software 2.0 product can be successful in the market.
4. If your product is a fully automated system that replaces a human, are you sure your model can generalize to edge cases as well as a human? Extreme sensitivity on edge cases or out-of-domain cases is necessary in most real-world applications. Even in lower-risk applications like industrial quality control, a heavy tail of failed edge cases might end up hurting your product's value. In safety-sensitive domains such as medicine, human-robot coordination, or safety inspections, failure on edge cases might be intolerable, and false alarms might be by far preferable. Evaluating models on unseen domains or distinct instances can be a way of judging if your training strategy can really replace a human where it matters. Some sort of out-of-domain detection training strategy might also be necessary, as out of the box accuracy maximization strategies are unlikely to work well with unseen instances.

