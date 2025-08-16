---
title: Data efficient foundation models
under_construction: true
excerpt: "Concrete concepts for developing useable foundation models with minimal data."
comments: false
share: false
img: ""
post_date: "2024"
priority: 1
---

Foundation models are notorious for being very data hungry. Segment anything was trained with 1 billion masks. CLIP was trained with >100 million image captions. 

However, it is possible to train useful foundation models with much fewer labels, using a number of very pragmatic tricks to utilize preexisting models and available data as effectively as possible. These tricks are powering a new generation of data-efficient foundation models that are bringing recent innovations from social platforms into the real world.



* Foundation model overview
    * Foundation model implies multi-task---usable for different real world workflows, different people trying to do different things.
    * Semantic multi-task requires open vocabulary---can use arbitrary natural language to describe objects
    * Multi-task requires some degree of human direction of what task to focus on
    * Encode task into model input
        * Segment anything: Point/box prompt as decoder input
        * Clip: Can choose either image or text to be the prompt
        * Conditional diffusion model: Choose masked image, get back full 
        * Chat-bot: Encode prompt into token sequence

Key ideas include: 

* Transfer learning from social media foundation models
* Focus on diversity over quantity
* Smaller model architectures (a big step down in data diversity vs natural images)
* Richer prompting to allow manual error correction

Examples include:


* Medical foundation models
    * [PLIP](https://www.nature.com/articles/s41591-023-02504-3): 
        * Twitter scraped data, 208,414 image-text pairs scraped with hashtags
        * Pathologists collaborate by posting unusual or interesting cases on twitter to discuss what they could be.
        * Critical dependency on transfer learning from CLIP
        * Extreme diversity, only rare and interesting cases make their way to twitter
        * A basis for virtually all open-vocabulary pathology models
    * [Virchov2](https://arxiv.org/html/2408.00738v1): Self-supervised feature encoding for pathology
        * Focus on dataset diversity
        * Pathology-specific loss function
    * [MedSam](https://www.nature.com/articles/s41467-024-44824-z):
        * 1,570,263 image-mask pairs
        * 10 imaging modalities and over 30 cancer types
            * CT images
            * MRI images
            * derm photographs
            * H&E Pathology scans
        * Smaller models (Vit-B model is big model, then lots of micro-models)
        * Focus on diversity over volume
        * [ScribblePrompt](https://arxiv.org/pdf/2312.07381)
            * Rich prompts for better control when model is not as smart
            * Needs somewhat more expensive decoder
    * [Medical LLMs](https://huggingface.co/blog/leaderboard-medicalllm)
        * Competitive and rich field, with proposed models from many LLM vendors (google, meta, etc)
        * Lots of scrapable medical data in pure-text format, but several orders of magnitude less than general text data.
        * Transfer learning from regular LLMs
    * Medical diffusion models
        * No clear winning model
        * Old tasks such as anomaly detection, nearest neighbors  and classification by looking at reconstruction loss or other discriminator.

### Clever bootstrapping and applications

* PLIP->Grounded object tagging: Using noisy PLIP generated labels to automatically train object detection model. **CVPR NOTES!!!**
    * Can generate a diversity of text headers for each source image
    * Can manually review/clean those generated headers for accuracy. 
* Medical Segment anything -> cell segmenter **MIDL Notes!!!**
    * No need to train specialized cell counter, only a very rough models to tell cells of interest apart from other cells.
* PLIP + cell segmenter -> open-vocabulary instance segmentation
* Medical LLMs + Virchov/PLIP image features -> Good start to train custom open-vocabulary models ontop novel data


### Anomaly detection models

Negative data labeling:

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


### In the wild labeling

* Report/image cross-correlations
* patient metadata/image cross-correlations


