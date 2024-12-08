---
title: Active Learning Excellence
under_construction: true
excerpt: "How active learning turned into an art at a small digital pathology company."
comments: false
share: false
img: /images/backprop/diagram-svg/whole-backprop.pdf.svg
post_date: "2024"
priority: 1
---

As for a life update, I indeed left my last job as planned but I stumbled across a medium sized ML company in digital pathology (https://techcyte.com/), and couldn't pass up the opportunity to learn more about how good businesses work, and how ML ends up working in practice. The reason the company is so interesting is that basically no one has a formal ML background, but they are smart and driven, so they just adapted off the shelf models and tried their best to make the models work for them. What they ended up building is not an innovative ML architecture or training code, but instead a novel human-centric active learning pipeline, which I will call "Iterating towards exemplars".

The framework is an object detection model. We are trying to identify and classify objects on gigapixel stitched scans of biological slides. The basic model is the YOLO (you only look once) framework. We fine-tune with the same pretrained weights that Joseph Redmon trained while developing the model 6 years ago, nothing fancy.  The data labeling process is:

1. Human experts label a small initial dataset manually, with whatever data they can get ahold of (~100s of objects total)
2. Fine-tune a model originally trained on Imagenet/Coco
3. Delete around 20-30% of the original dataset, especially deleting objects with looks that already perform well, or already labeled in the dataset (selected manually)
4. Run the model on the dataset to generate more labels (~1000s of objects per class)
5. Verify "exemplar" labels which represent clear examples of different real biological looks. Blurry objects or objects with artifacts are left out.
6. Pick out high confidence false positives and explicitly add them to the dataset. 
7. Delete all objects generated from step 4 which were not verified. 
8. Repeat from step 2. 

What ends up happening is that the dataset iterates towards only having novel examples in the dataset, and we end up training reasonably successfully on pretty hard detection tasks with only a thousand or so objects per class. This tiny dataset allows a few interesting features:

1. A single person can review the entire dataset in a few days.
2. A class in the dataset can be fundamentally changed (i.e. split into two classes) in a day or two
3. The domain expert labeling the data has enough control over how the model performs by how they delete/add data that they are responsible for the model's performance, not software developers. This is nice on a personal level, way less pressure on deadlines and such.

Working at the company is fun for a few reasons. Partly, even though I am not exactly a qualified ML person, and I lack certain attributes/talents that are important in that field, I get to be a bit of a domain expert because almost everyone else is even less qualified. This works because they are relatively smart and qualified in other areas (i.e. our cloud infrastructure is quite nice). It is also fun because it is cool to just watch the human domain experts learn about the ML tools, and end up training models without any formal experience in math, computer science, or machine learning. And they take ownership of their success or failure and develop a rough, but effective intuition of how it all works. They are also just much nicer people than engineers, and unlike engineers, they are capable of reading and following instructions, so they are nice to work with.  

Not much else is going on in my life. Last year, I even moved around the country for almost a year (Denver, Pittsburgh, Boston) to find a place to live that I would find easier to engage with, but I ended up just moving back to Idaho in the end. The tale of taking your problems with you wherever you go is a very real one. I used to think that physical location was very important, now I think that there must be some more nuanced fact that I was misinterpreting.
