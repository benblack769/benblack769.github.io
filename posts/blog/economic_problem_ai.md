---
title: "The economic problem of AI"
slug: economic-problem
under_construction: false
excerpt: "An essay on the barriers to technological development of AI."
comments: false
share: false
post_date: 2020
---

### The purpose of technology

Why do you use technology? Do you play with it? Perhaps you do. But, what about the technologies you are still using from 10 years ago? Are they just toys or something more? Are they something that fits into your life like a belt, tying things together, making your life a little easier, a little more convenient, a little brighter, a little less lonely?

If someone offered you the exclusive ability to use an AI system, that no one else had, when would you use it? Perhaps if it made it easier to get to work? Perhaps if you noticed it was better at you at sales predictions at work? (assuming you could pass that work as your own) Perhaps if it notified you about good deals on craigslist you might be interested in? Perhaps if it took notes for you, and edited the grammar and spelling mistakes for you? Perhaps if it read your emails for you and noted what is important?

Oh, wait, all these technologies already exist. In fact, you and me are thinking about them precisely because they already fit into our lives so well. If we had to upend our lives to adapt to technology, not only would it be difficult to imagine, but we probably wouldn't want to make that step if we had the choice! So our imagination of improvements are necessarily incremental, based off the cultural, institutional, and technological structures that already exist.

### The paradox of intelligent systems

Then what is all the hype about? What is it that people are so excited about for the future of AI? Well, AI can learn. Learn to do these things  we already do, but so well that we can trust them and we are suddenly free to do something else. So they claim it can  learn to drive cars, or translate documents, or read resumes, or answer questions, or perform technical support so that we don't have to.
But if you are depending a system to do important work in our stead, you want to be assured it will do an acceptable job, right? And how will you be assured of that? Will it be acceptable for the system to be tested in real life scenarios for an extended period of like, like a clinical trial in medicine?

If it is, then won't the system have to be fixed in place during and after the test? Unchanging, meaning, not learning? If not, then how else would you come to trust the system? An alien system that is somehow fundamentally different than anything we have seen before?

So it seems as though to rely on an AI system, it has to stop learning, and therefore to stop being intelligent. Before you think this is some sort of paradox, recall humans have a similar system in place. Adult humans actually have fewer connections in their brains than infants, and instead focus on being reliable in the ways they are depended on, staying focused for long periods of time without distraction.

So an intelligent system that adapts and learns must transform into an expert system, which is solid, reliable, and useful. I argue that this is a difficult problem.

### The difficulty of transfer learning

Ok, you might be wondering, what is so hard about that? It is just software, why can't you just have it learn until it becomes good enough that we can rely on it, then stop the learning processes, and just keep the execution processes? Sure, but how did it learn in the first place? How does that learning process align with its eventual goal?

Well, why not start out by learning directly from its final goal? That is the strategy of most machine learning approaches today. Have a dataset, or a process that generates data, and a reward function that tell the system how good of a job it did. Then the system adapts to that reward, and slowly gets better. This ideas was first popularized by a phsycologist Pavlov, and his experiments with dogs, which used reinforced conditioning to get them salivating at the sound of a bell. Talk to a psychologist, however, and you will quickly learn that this approach is fatally flawed. First, capturing all the reward information in a scalar, or even a small set of scalar simply isn't much signal to learn on, and will take a very long time to learn anything of use. Even if this problem is overcome,  the signal need to be reinforced again and again, or else it will be forgotten. And if you keep on needing to be reminded of old stuff, how do you have any hope of learning higher level and more abstract material? Seems hard.

Now, psychologists have another idea of how a system learns. The learning agent must have its own objectives, and absorbs the world into its ideas. It is constantly reinforcing its own objectives, allowing its most solid ideas to stabilize completely, and allowing it to build layers of abstraction on top of the lower level layers. Occasionally, the world pushes back, forcing the agent to understand its limitations, questions its objectives, and restructure itself to better accommodate reality. But it can learn these limitations precisely because it already has a mostly accurate understanding of the world. But ultimately, what are these objectives? How do we trust a system with its own goals? How do we understand it well enough to train it for our needs while it is trying to learn its own thing? How did we design it in the first place when its learning process is so distantly separated from our experience and knowledge of the world? How do we stop the chaotic processes of learning so we can test and productize it, while still allowing it to adapt to new problems it encounters while doing its job? Seems hard.

### The difficult economics of AI research

Perhaps there are answers lurking to these questions, but in the meantime a question remains. What are we trying to build in the first place? Do you want to make an intelligent system beyond our understanding and control (like a human)? Or an expert system that fits in a technological niche, but has a shallow understanding of the world as a whole? Ultimately this can be framed as an economic question, that is, what should we allocate resources towards? This is the economic problem of AI.

Why is this so hard?

So lets say you have a lot of venture capital money, and you are trying to produce an expert system. Say self-driving cars. What are your resources? Expert consultants and engineers who have spent a career specializing in the old technology you wish to replace? Academics who only care about publishing in journals that look at success on popular problems, not the ones you want to solve?

It gets worse. They are saying you are crazy for thinking you can do a better job than Tesla, with its infinite data, or Google, with its infinite human capital. Lets say that you wanted to prove them wrong. How would you go about saying your self-driving car is better? Let it drive it for millions of miles on the road? What an expensive way to get sued. Instead, lets say you spend a couple years designing a high-resolution simulation with hundreds of complex scenarios to test your system on. But can you enforce the discipline needed to only use this as a testing resource, and not overfit to it? And even with discipline, can even hundreds of carefully designed situation really capture the infinite complexity of the real world?

Building intelligent systems is even more ambiguous. What is intelligence anyways? Are you sure you are not being biased by human notions of intelligence (which are at far too high a level to be useful)? How will you convince your fellow theorists that your idea of intelligence is the best one, able to generate most of the others?

Perhaps you build an intelligent system, and find a task that it performs well on. Well, can your intelligence system really compete with all the expert system people, and all their heuristics, shortcuts, and human generated data? If not, then what do you have left? Vague arguments about principles? That is where you started out! If your system does compete, then it will necessarily be on an unpopular or very complicated task where those shortcuts haven't been highly tuned and the human data hasn't been collected because it is too expensive. But if the task is so complicated, how will you explain its accomplishments to theorists who aspire to clarity and cleanliness in their work? If it is too unpopular, then how will you get people's attention?

It gets worse. They tell you that your method is just another shortcut, perhaps more elegant and successful, but they label you as another expert system designer always, and write off your success as slow and meaningless progress.

Frustrated, you take another approach, and try to simulate animal behavior directly. You dive into neuroscience, create theories of the fundamental computational processes of animal brains, create simulations to test them in, but then you run into a problem. The real world is incredibly sensor rich. Simulating all these senses requires incredibly expensive simulation resources you don't have the money and organization for. So you build a robot. But the sensors still aren't that good. And you realize that animal brains are incredibly well tuned over millions of years of evolution involving trillions of individuals, and you have to do all this tuning yourself in a small poorly funded lab. And you need a tangible success to renew your grant.

It gets worse. You try to see what other people are doing to improve your work. You read the literature, contact professors, try to connect people working on this problem. And you get a mess of exaggerations, lies, omissions in the literature (how else are they supposed to get grants?), and rampant idealism and ungrounded thinking in person (because who is dedicating their life to this impractical problem in the first place?).

Like most economic problems, the real problem is that there is no "we" that are able to "allocate" resources to the advancement of artificial intelligence. Everyone has to choose their own risks their willing to take, and make their own judgements of what is good and bad. And in the face of uncertainty, the different parties are doomed to clash in their judgements, and overrun each others tolerance of risk. People point towards charismatic heroes of technology, like Elon Musk, who seem able to take on infinite risk, and are able to force everyone under their judgements. But are they really up to the task? Can a few overworked elites really be expected to make the right judgements? Seems unlikely.

### On the ease of AI progress in principle

So why do these elite technologists have such confidence in the of inevitable and rapid progress of AI? A few possibilities present themselves.

First, what is the physical basis of intelligence? Computation speed? Memory? Approximately how close to humans are we in these basic metrics? Well, deep learning cluster training currently operates on hundreds of GPUs or TPU clusters, with trillions of transistors, terabytes of high-speed GPU RAM, petabytes of low speed data, petaflops of compute, and terabits of total intermachine bandwidth. Compare that to the 10 billion cells and 100 trillion connections in the human brain, which operate at a much lower speed, but are much more tightly connected, and you get a reasonable picture of where we are at. Where will we be in 20 years?

Second, what is the conceptual basis of intelligence? Well, I know of an intelligent being we can base our AI off of, do you? Oh, I was thinking about a rat, was that not what you were thinking of? The conceptual foundation of intelligence is weakened greatly by anthropocentrism, but we can study all sorts of animal intelligences as they develop. We can measure their brain activity (at a high level, at least), stimulate their neurons, change their hormones, and see what possibilities there are. So what is left? Improvements to the theory? Better ways to test these theories? Can't computers and simulations test the theories precisely as they are put forward?

Third, what is the practical basis of intelligence? Well, when does intelligence shine in human activity? During tests? Financial analysis? Scientific insight? Social collaboration and coordination? Conflict resolution? Physical reflexes? What human experience contains all these aspects? What experience that makes us revisit all our preconceptions of right and wrong, of what our place in the world is, that expands our notion of what is needed in our lives? What experience where large communities are driven in common to find new resources, new ideas, new strengths? I have an answer in mind, but any answer to these questions gives a powerful case for the overwhelming utility of AI, in any capacity, at any level of sophistication, and any degree of ubiquity.

### Dynamics of technological progress

So how is AI both very easy and very hard? How does this affect our view of the future?

The one truth behind all technological development is that for technology to really progress, not only does the technology have to adapt to our needs, but we also have to adapt our lives to fit the technology. As long as there is little immediate reason to change our lives, we won't do it. As long as technology doesn't affect our lives, research in that technology is ungrounded, and therefore unproductive. As long as technology does affect our lives, we become accustomed to its limitations, and have a hard time giving them up for something new.

Unlike other technologies, the potential of AI is nearly infinite, but so are its drawbacks.
So expect many more periods of hype, expect stagnation and backwardness. Expect weird biases and inexplicable failures to be a reoccurring feature as transfer learning transfers some weird shit over from one task to another. Expect rat races in adversarial scenarios, as people find and patch exploits in these bizarre systems. Expect periods of regress, even when systems get so wrapped in bandages the whole thing crashes down.

But remember the potential that a powerful purpose can be found for AI which somehow aligns our efforts, judgements and risk with the true nature of self-organizing intelligence, and directs an effective hierarchy which organizes efforts to make the dreams come to life. This would have to come at the right time. When the concepts behind intelligence are actually out there. When the difficult hardware development is sufficiently far along.
