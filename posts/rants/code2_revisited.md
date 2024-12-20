---
title: "Human-powered Code 2.0"
slug: code-20-revisited
under_construction: false
excerpt: "The dream of Code 2.0 is only starting to be realized. A human-centric framework of successful Code 2.0 teams is starting to emerge."
comments: false
share: false
post_date: "2024"
---

Back in 2017, Andrej Karpathy wrote [an essay titled Software 2.0](https://karpathy.medium.com/software-2-0-a64152b37c35) about how Deep Neural Networks are empowering a shift from building software from code to building software with data. This shift is now referred to more often as Code 2.0. In particular, when giving meaningful semantic interpretations to raw data coming in from the real world. Inspirational problems include:

1. Industrial production quality control: is this image of a good product or a faulty product?
2. Digital diagnosis: Is this patient healthy, and if not, what is wrong with them? Where is the anomalous issue on the large/detailed scan?
3. Agricultural optimization: Do these plants need more or less water/fertilizer? 
4. Routine Infrastructure Inspections: Do these pipes/cables/etc have cracks/faults that are worth looking into more deeply?

These simple semantic evaluation tasks are powerful on their own, and can drive quality control and efficiency in many important industries. However, that is not the limit of Code 2.0, as it can be enhanced with traditional algorithms for more complex planning and control tasks like:

1. Using high quality semantic positional evaluation to  efficiently search a game tree for optimal game play (AlphaGo)
2. Judging similarity between robotic position and human position for robotic imitation learning 
3. Judging design decisions for high level circuit-silicon block mapping for effective chip design.

These tasks have traditionally been extremely challenging to machine learning professionals, with professional histories often registering more failed or underperforming projects than successes. Aligned industries tend to be somewhat risk-adverse, attracting more risk-adverse professionals, operating in a conservative, incremental manner. Leading to an overall under-utilization of the Code 2.0 stack, despite the hype and perhaps over-utilization in a more risk-seeking "Tech" industry.

Code 2.0 offers a solution to this professional anxiety: I, as a computer scientist, don't have to run the show. I don't have to reason about every detail of the algorithm. I don't have to customize or tweak everything to the details of my issue. Rather, I can take a supportive secondary role where I build the platform and the infrastructure that ingests and trains a model on the algorithm and someone else can worry about the details, by developing the data, and ensuring that the data is actually sufficient to solve the problem. 

Its very similar to how a hardware developer, after the code 1.0 transformation caused by the development of the microchip, no longer has to drive every detail of the hardware's behavior. Instead, when confronted with a novel problem, they focus on assembling a platform, mostly from ready-made components, and simply ensure that the specs and configuration allows the software to do what it needs to do, without worrying about the details of how the software works or how it is developed.

Industry leaders like [Andrew Ng](https://landing.ai/) have been championing this concept and starting startups with the hope of powering this Code 2.0 development with powerful training/inference platforms. However, understanding of the philosophy of this workflow is still poorly understood, leading to defaulting to more well understood, but slower and more wasteful Code 1.0 workflows based on static dataset collection.

## Barriers to Code 2.0 development

Code 2.0 has several barriers to implementation, the biggest being:

1. Projects are still driven by computer scientists, accustomed to a code 1.0 workflow, especially in the U.S. (China's businesses are better about this) This means that data development has a waterfall workflow where large amounts of data is collected/cleaned according to some fixed scheme whereas algorithms are developed in a fast-iteration agile workflow. Which limits the amount of creativity and experimentation with data development. 
2. Downstream and upstream challenges in edge hardware, networking, database integration, human review processes, business logic, and sales are often much higher than machine learning challenges, meaning that improving machine learning processes are treated as a second class problem.

The second issue tends to get easier over time as the rest of the system matures. But the first issue does not get solved by time, rather it is driven by computer scientists running the show. Below, I'll explain the principles involved in making someone else the center of Code 2.0 workflows.

## The Code 2.0 Team

In 2022, I joined a fascinating mid-stage startup that checked all the boxes. It did automated analysis of raw real world data, it had a real business model, and it was run by good, pragmatic people.

They built remarkably human Code 2.0 workflow, centering on the humans labeling the data, the Data Managers (this is not an inflated title, they really managed a lot, and a lot of project success depended on their skill). Unlike Code 1.0 workflows, where the labelers simply hand off the data at some point, at this company, the data managers iterated with product advisors to determine the best way to label the data, actually labeled the data, trained the model, used the model to find good labels to add, evaluated the model, built out metrics, advised studies, and more. The remarkable scope of their responsibilities meant that relatively little time was spent on actually labeling or reviewing data, maybe 40% of their time on average.

### The Code 2.0 Data Developer

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

These demanding requirements pave the way for a whole new skilled craft---the Code 2.0 data developer.

### Processes in Code 2.0

While all the intellectual demands above are important, there is a much greater degree of mind-numbing grind in Code 2.0 development than Code 1.0 development. Combined with the high degree of responsibility and focus of understanding on the Data Manager, second guessing/anxiety and decision exhaustion are huge problems. 

To minimize this second guessing and allow for the possibility of smooth flow in the labeling, targeted processes can be established to commit to workflows that are understood to work, and see changes through to where success can be determined.

However, it is important that processes take a second-place role behind the human Data Manager. Junior Data Managers can work with a more senior one to help work through tricky issues and to get ideas of effective processes to solve those issues.

### The Code 2.0 Platform Developer

Code 2.0 is built ontop of Code 1.0, similarly to how Code 1.0 is built ontop of hardware. Which means that Code 2.0 still needs regular software developers to build the system that powers the Code 2.0 data management workflow above, help collect raw data from edge sources, and build out any inference pipelines in the application. The role of the Code 2.0 developer is to be a supportive engineering/data operations role that takes second-hurdle to the Data Manager. As this was my role, I identified a few principles which helped me be effective in this position:

1. **Minimize ML Configuration:** Data Managers are not machine learning experts, and struggle to understand the details of all the knobs that ML Engineers typically build into their platforms (learning rate, batch size, etc). The number of knobs that need tuning for best performance, the less effective the Data Manager will be. Good defaults, effective heuristics, and automated hyperparameter selection are key to keep DM workflows efficient.
2. **Inference pipeline/Evaluation pipeline equivalence:** The inference pipeline that the data manager uses to evaluate the model must be near-identical to the production inference pipeline. Otherwise, unexpected behavior in production is a big risk.
3. **Avoid lockin on pre-processing techniques:** Real world data often needs quite a bit of pre-processing to feed into an ML pipeline. Grabbing manageable subsets by cropping images, grabbing video/audio snippets, chopping up text into chunks, etc, is common. Compression pre-processing, such as generating audio spectrograms, static image/text embeddings with foundation models, etc, is also common. If your data labeling strategy locks you into the specific style of pre-processing, this can harm your ability to improve the system. These pre-processing choices have meaningful and significant impact on end performance. In my job, I made more end performance improvements tuning this pre-processing than any changes to loss function or architecture, and many other ML engineers have the same experience. Simply retaining the ability to re-generate these on demand is sufficient.
4. **The Cloud is best for Code 2.0 development workflows:** For Code 2.0 workflows, the best parts of the cloud are shows at their very finest. The cloud's fast scalability and ephemeral qualities are perfect for the very spiky Code 2.0 GPU hardware demands, and ephemeral nature of most intermediate training artifacts. However, its important to not lock into a inference provider---cloud, on-premise or edge inference are all important capabilities.

### The Code 2.0 Domain Specialist

Another key role is domain specialist, a true expert in the domain. This role is key to building a robust product which is useful in practice and trustworthy. This role helps gauge the scope of the model, offers criticism of the model's performance, and helping find difficult cases and identify failures. 

Generally speaking, this role needs to have the following philosophy in mind:

1. **Deep practical experience:** The specialist is ultimately the main arbiter of feature priorities. So they must understand the risk/reward benefits of every feature, which requires a deep experience and understanding of the industry.
2. **Distance from model development:** Sadly, whenever we collaborated with a specialist who knew a lot about machine learning from, reading, research, or academic projects, the project went much more slowly and painfully. The reason is that the specialist, out of curiosity, tends to and offer incorrect advice about what will work, what should be attempted, and other unnecessary meddling into the Data Management process which typically increased friction and reduced trust. One one person can truly own/lead the data development process, and that person needs to be in the data every day, following the image of the Data Manager above. Of course if this person happens to also be a specialist, that can work, but its rare to have true expertise in two fields.
3. **Education-Minded:** The domain specialist is an invaluable source of information for the other team members to learn about the details of the application. Having a teaching mindset is valuable for this purpose.


## The Code 2.0 Process

In our experience dealing with Code 2.0 problems and figuring out solutions, there have been some insights into what is even important to focus on, and what is secondary. The profile is very different than Code 1.0.

### Reviewing Code 1.0

To emphasize the differences and changes one can expect from a Code 1.0 process to a Code 2.0 process, lets review the basic Code 1.0 development process.

1. Determine labeling strategy+classes
2. Label training+test dataset, the larger and cleaner the better
3. Determine metrics to evaluate model on
4. Iterate on model/learning strategy, attempting to improve metrics
5. Go back and review steps 1,2, and 3 if step 4 can't yield good enough results.

### Code 2.0 process

Meanwhile, the code 2.0 process emphasizes data iteration over model iteration, so it looks more like this.

1. Determine labeling strategy+classes
2. Determine model/learning strategy
3. Iterate on training dataset, evaluating as one iterates
4. Determine metrics to judge final model on
5. Review steps 1, 2, and 3 if the model doesn't pass the bar.

### Key findings:

#### De-Emphasis of Metrics in Code 2.0

The most surprising finding to an ML engineer is how *unimportant* metrics end up being in a Code 2.0 workflow. In Code 1.0, no solid progress on models can be made without solid metrics, so its become a *good* dogmatic assertion that metrics development comes before model development, and any model development is constrained by the capabilities of the metrics to measure the true performance.

However, in Code 2.0, metrics are secondary. The reason is because the Data Manager is reviewing model results all day, every day, and they develop an intuition for model behavior independently of any metrics there may be. 

Furthermore, this model understanding can often be *superior* in finesse to any metrics one might hope to design. If there are any downsides, it is that metrics look at a lot of data at once, vs a data management process that typically subsamples the data during review.

#### De-Emphasis of Data Size in Code 2.0

The second surprising finding is how little data one really needs in Code 2.0.

#### Re-Emphasis of data inspection/visualization tooling

#### Re-Emphasis of data 


<!-- 
## The Code 2.0 Business

With these key roles in place, the Code 2.0 team starts to take place. 

1. Lead Data Manager
2. Assistant Data Managers (they also need to have very good data/model understanding, but defer on product-related decisions)
3. Machine learning consultant/platform devops helper:
4. Specialist domain consultant.
5. Product lead -->


