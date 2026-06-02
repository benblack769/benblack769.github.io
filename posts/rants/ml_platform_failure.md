---
title: "Expert Systems are Still Hard"
slug: expert-systems
under_construction: false
excerpt: "We now have 3 generations of AI methods and technologies to develop expert systems with --- rule-based systems, machine learning systems, and now LLM reasoning and knowledge systems. Reliable expert systems remain hard to build despite this expanded toolset."
comments: false
share: false
post_date: "2026"
img: ""
---



### Expert Systems

Artificial Intelligence AI is exciting. It learns! It adapts! It can do things it wasn't built for explicitly! Technologists, grant-writers, and and venture capitalists eat this up, and have since the 1960s, when the first wave of AI hype received tens of millions in funding. But when the bills start showing up, the real business and government leaders paying those bills start demanding results. 

Those results do not come in the form of "learning". Results do not come in the form of "doing something it wasn't designed for". Results come in the form of

* **Efficient resource utilization** --- applying fertilizer exactly as needed, and no more. 
* **Job replacement** --- computers doing at least part of the job of a trained, possibly certified human.  
* **New sources of data** --- ingested at a scale too big (i.e. an entire city's security cameras) or too small (i.e. microscopic imaging) for humans to effectively review. 
* **Quality control** --- computers adding consistency and reliability to the work of hundreds of diverse humans.

This is what justifies those bills. Reliable solutions to real problems. Expert systems, not AI. Businesses selling such systems eventually learn this lesson, and strip the words "AI" from their marketing language

* Self driving car companies have mostly stripped the words "AI" from their marketing [Waymo](https://waymo.com/intl/es/), [Ford](https://www.ford.com/technology/bluecruise/) ([Tesla](https://www.tesla.com/ownersmanual/modely/en_us/GUID-2CB60804-9CEA-4F4B-8B04-09B991368DC5.html) stripped it off and added it back during the recent AI hype bubble)
* Tempus AI --- the leading AI medical company has been slowly walking down how much they advertize their products as AI --- typically measured by maturity, the older the service, the less its marketed as AI. https://www.tempus.com/news/ Instead, its "assays", "tests", etc. Language in the terms of the profession, i.e. expert language.
* Chess engineers --- [Stockfish](https://stockfishchess.org/) and [Leela Chess Zero](https://lczero.org/), the two leading chess engines, do not mention AI on their websites. Chess used to be the ultimate problem in AI, deep blue was the confrontation of "intelligent computer vs intelligent human". Now, they call themselves "chess engines".

### Expert systems and professions

Expert systems are technology's version of a profession. A professional, to get and keep their professional license, has to be educated in a certain way, demonstrate their knowledge, keep up to date on the literature, etc. 

Expert systems are the same. Its not good enough for a technology to be well known, or have a good brand. Expertise must be demonstrated. Knowledge must be kept up to date with shifting circumstances. 

### Machine Learning 

We software engineers love to be the people who "build the machine that builds the machine".

In ordinary software development, this dream is beautifully realized when developing successful of software libraries and frameworks. A library or framework can be used by thousands of other software developers for all sorts of tasks and incorporated into products we could hardly imagine when we built them. 

But machine learning is different. While traditional software is most often an interface from one exact computer system to another, which can stack in layers and chains and complex webs of spaghetti code without error, machine learning systems are interfaces from the computer to the physical world. The physical world is messy and noisy, and nothing you do can completely eliminate this noise and uncertainty. No matter how wide your feature vectors are, there will be some detail in the input that isn't captured. No matter how exhaustively you try to label a train or test set, there will be a long, thick tail of edge case situations where the model won't quite get what's going on. 

This error accumulation means that abstract software patterns just don't really work in ML. Layers and chains have to be built in such a way that downstream components detect and correct errors in upstream components, a very inefficient approach since it typically requires a lot of second-guessing, re-running, and random sampling of the problem space. And complex spaghetti code systems are doomed to just fail catastrophically.

This is not just a problem with machine learning. Its a problem anytime you are using computers to try to deal with uncooperative physical reality. Robotics has a similar problem. So does rocket science. So does so-called computational science (using advanced software algorithms to help reduce cost of performing scientific measurements).

### Bottom up vs top-down evaluation

The most custom, most specific part of any ML project is evaluation --- how well did the system perform?

And identifying and correcting for these errors is hard. Unlike in signal processing, where noisy signals can be detected and error corrected, in machine learning, there is rarely a cooperative party on the other end trying to re-send the message so you get it. 

And so if you just stack models ontop each other, these errors will simply compound with each other until you get complete slop.



Attempts to generalize this to machine learning have largely failed. Of course there are certainly highly successful libraries for training a model (i.e. Pytorch), monitoring models in both training and production, and deploying models (i.e. onnx), and labeling data (i.e. fiftyone). 

However, the successful libraries and frameworks earn their successes by not being opinionated about the key items:

* How data is labeled
* How results are evaluated numerically
* How 



The community has been building more and more specialized versions of each of these that incorperate more advanced feild-specific reaserch there are some components that cannot be abstracted, and must be carefully built to purpose:

* 

### 
