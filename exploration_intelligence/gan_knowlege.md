---
title: "Generative adversarial knowledge"
slug: gan-knowledge
under_construction: true
excerpt: "An essay on the way that Generative adversarial networks break our understanding of knowledge."
comments: false
share: false
---

How is knowledge obstained? What is knowledge in the first place? These two questions have dominated an entire branch of western philosophy for centuries (epistimology). More practical fields evade the problems of epistimology by defining their own standards for knowledge.

Science asserts that knowledge is a model of the world. A description of the causal or correlational chain of events that allows us to predict outcomes. These descriptions should be compact, so scientists can write them down and communicate them. They should be based off reproducible evidence, so scientists can check each other's work. The causual chains they study should be potentially useful, or at least seemingly fundamental, so that scientific instiutions aren't wasting too much money and talent.

Machine learning reaserch asserts that knowledge is the ability of a computer to minimize a cost given data. The data should be avaliable so different reaserchers can compare results. The parameter space of the model should be large, but the learning process itself should be compact so that reaserchers can communicate progress. The cost function measured should be potnetially useful, or fundamental so that reaserchers aren't wasting too much time.

As you can tell, the epistimology of machine learning reaeserch is a very small change off science. There are only two differences:

1. The model of the world can be extremely large and complex, as long as the process to generate that model is compact.
1. Average error of the model is measured as opposed to gathering evidence for the truth of a model. In other words, some error is expected, as there is no reason to expect that the model is somehow "true".

Now this model of science, and its child, the current model of machine learning, have a very sucessful history. They have come to dominate universities and academics, crowding out historically succesful knowlege models such as

* western philosophy in areas like political theory and economics
* religious theology globally in areas like physical and psycological wellness

So the question becomes, is the knowledge model of science really robust enough to handle these relatively new areas? Or are we extrapolating too far from science's success in physics and chemistry?

As a machine learning person, I hope to suggest answers using analgogues in the contrained domain of machine learning.

### Pathology of knowledge models

Questioning the adequancy of science should seem strange, especially from a scientist. However, I am asking that you have a little humility for a moment.

First take a note of the pathology involved in defining a knowledge model. First, you are taught that science is the only source of useful knoweldge, anything else is untrustorthy. Then, when knowledge comes to you via a different source, you are expected to throw it out as illigitamate because it is not science. So under no circumstances can foundations of science be questioned under those same foundations. This problem is well understood in epistimology: even Karl Popper has admitted that the ideal of fasification is not an empierical truth that can be falsified.

### Escaping the trap of knowledge models

The only way to escape the trap a knowledge model imposes is to find some knowledge so useful, so powerful, that it cannot be ignored, indeed, ignoring it would spell disaster.

In the early history of science, this knowledge had small scope. Copernicus's model of the solar system only disrupted the activities of a few theologans. Because science was a good knowledge model, the scope started to increase. Robert Boyle's ideas of chemical distilation in the 1600s started to produce discoveries such as  transformative results in the 1800s in the form of synthetic dyes, smokeless gunpowder, dynamite, chemical fertilizer, etc.

We are currently in the early history of machine learning. Is there something that is breaking out of the fold, leading us to a new model of knowledge?

### Generative adversarial networks

A generative adversarial network (GAN) is a machine learning based model that none the less breaks the assumption of a communicable cost function. Instead of having a cost which the model tries to lower, the model tries to solve a game.

This game has two players. Player *GEN* generates an image, player *DISCRIM* evaluates that image.

* Player *GEN*'s goal is to generate an image which player *DISCRIM* rates highly.
* Player *DISCRIM*'s goal is to differentiate between the images that *GEN* generated and a known set of images.

The ideas is that as this game is played, *GEN* produces increasingly realistic images in order to confuse *DISCRIM*. So this process will create a model *GEN* which produces realistic images from scratch.

The fact that this works as well as it does should be mind-blowing. There are so many things that could go wrong when trying to solve this game. *DISCRIM* could start working too well, giving *GEN* no chance to improve itself, since every image is equally bad. On the other hand, if *DISCRIM* works too poorly, *GEN* will be able to easily fool it with unrealistic images.

So given all this uncertainty about why it works, how do we know that it works at all? Well, just look at outputs.
Ever seen a deekfake? The model which generated it was trained by a GAN process.

This process of "look at it, and see that it works" is the gold standard in GAN evaluation. Of course, scientists have disovered clean metrics which correlate with our feelings about these images, but they are considered to be weak and fragile measures that are not to be taken too seriously.

### Implications of GANs

This evaluation process is why GANs are so exciting. In the early days of chemistry, for example, people would disagree on terminology and theory. The thing that brought people together who otherwise didn't like each other and worked under different assumptions is clear displays of functionality. For example, the display that pumping air out of a chamber extinguished a flame. A beliver in the 4 aristotelian elements would have a hard time understanding this concept by explanations or theories, but a display of it should convince even the hardest skeptic.

In other words, when you have to resort to displaying your results directly, without any interpretive framework, and people are forced to take it seriously due to its uniqueness and usefuleness, that is when real progress is being made.

So where is this progress leading? Well, I don't know for sure, of course, but I suspect it is leading to a place where instead of designing models or designing cost functions, the machine learning community will start desingning learning games, and methods of solving those games. An intermediate step in these games will be a model which is extrodinarily useful to robotics or medicine or text processing.

### Redefinition of knowledge

Building tools can be readily conceptualized. I suspect though, as these tools begin to become more important, and more people start specializing in their development and use, a new understanding of knowledge will arise. After we will start to absorb tools into our workflow, it will become useful to describe the things they do as knowledge. I "know" this sick person requires this medicine because my phone app told me. Even though no one knows exactly how the phone app got that knowledge. I "know" how to build a structurally sound bridge because I took a picture of the area, and the app outputted a 3d model of a bridge. Even though its not clear how the app figured out the structural properties of the land the picture is about.
