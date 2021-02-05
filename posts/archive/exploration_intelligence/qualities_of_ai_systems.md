

The qualities and flaws of directly trained expert systems are well known.

* Directly supervised systems are fragile, extending poorly beyond the range they are trained (the failure of the [ImageNet](http://www.image-net.org/) training dataset to generalize to [ObjectNet](https://objectnet.dev/) shows this directly).  
* Self-supervised systems trained on parallel data take easy shortcuts when uncertain. Machine translation systems produce [fluently inadequate](https://www.aclweb.org/anthology/W19-6623/) translations, that is, translations which sound right to a reader, but which fails to capture the semantic meaning of the source text. Image prediction systems often produce blur, or fail to capture global structure, creating weird dystopian distortions. In contrast, children learn to draw global structure first, then local structure.
* Reinforcement learning is hopelessly data inefficient on its own. A single, possibly sparse scalar reward is just very little signal to learn on, so exciting RL research like AlphaGo or AlphaStar require millions or billions of examples to train on.
* Transfer learning relies on the success of one of the prior methods, and so can only succeed to the extent that they do.

Ok, so what about systems that learn on their own? What are their features and qualities? Well, we don't have as many examples of this, as these are much harder to understand, but we do have some:

* The process of gradient descent in deep learning can be viewed as generating its own reward, but to a very limited extent. Like all self-training systems, this aspect of the training is hard to understand. The biggest problem to date with this is adversarial weakness, that almost all deep learning systems are incredibly vulnerable to adversarial attacks, making them useless in places like self-driving cars.
* Generative Adversarial Networks, the basis of deep fakes, are perhaps the most impressive self-training system, truely changing our view of what computers can accomplish. And also the most difficult machine learning system to train. Training these things is a black art, similar to alchemy, which is passed down from tutor to student, and is completely impossible to anyone who just reads up on the literature of the subject. Other than deep fakes, it is not clear what their purpose is. They are able to produce photorealistic images, but fail at more abstract images (traditional predictive networks perform better at this).
*

We are getting some results in both areas, with some systems, like machine translation, completely on the side of supervision and rewards, and others, like Generative Adversarial Networks (that form the basis of Deep Fakes), mostly on the side of individually generated rewards. But both have this inherent conflict with our true goals.

But if you look at the history of GANs, they are extremely hard to train, requiring a 5 years of fast-paced, intensive research, and enormous hardware resources to get to their current stage. And ultimately, even this technology, which more than any other, I would say, changes our understanding of what computers can do, fits very poorly into our lives, and people are still wondering what practical purposes it can have. After all, its goal is precisely to fake images. To generate things which are very close to real, but not identical to anything else. But we have no way of measuring that closeness, and we have reliable ways of discerning a generated image from a real one. So it still seems gymicy.
