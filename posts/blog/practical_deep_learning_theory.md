---
title: "Practical Deep Learning Theory"
slug: practical-dl-theory
under_construction: true
excerpt: "Rigorous Deep learning theory for practioners: What formal conditions ensure that neural networks will work well, and how do we check whether these conditions are being met?"
comments: false
share: false
post_date: "2022"
---


Deep learning theory struggled for a long due to focusing on *engineering* deep learning methods. Typically, a reasercher would attempt to define a DL training algorithm that *always* has certain convergence properties, so that a practitioner would be able to use this method with confidence it will *always* work. However, it turns out that the constraints necessary for these general, prescriptive proofs to hold hurt performance greatly in practice, and that methods *without* these provable guarentees consistently worked far better than those *with* them. This sort of theory is largely regarded as a failed project.

So successful deep learning theory started to take a more *descriptive* apporach to their subject of study.

1. Identify theoretical conditions which would ensure for certain desirable convergence/performance/robustness/generalization properties, assuming they hold.
2. Find fast algorithms to evaluate a metric that indicates the extent to which property holds on an instatiated deep learning training system. 
3. Determine if this property is fairly common in successful training regimes that empericists have already built. If so, then it can be assumed to be an important property in the success of these deep learning systems.

After this theoretical work, you, as the practitioner, then have a powerful monitoring metric avaiable that can help you determine if there is a problem in your training regimes. Once you have narrowed the problem to a well understood theoretical difficulty in trainning, you can look towards your fellow empericists and experienced ML craftsmen to look for suggestions in debugging, data normalization, and algorithmic techniques (in that order) that have been found to help improve this metric, and thus hopefully improve your overall training performance.

This post goes through several of the most important theoretical properties using this approach:

1. [PL condition](polyak-lojasiewicz-condition)
1. [Condition number/Lipschitz constant](lipschitz-continuity)
1. [Overparameterization](#overparameterization)

Most credit should go not to me, but to to Soheil Feizi and his Deep Learning Foundations course (avaliable for free on youtube)[https://www.youtube.com/playlist?list=PLHgjs9ncvHi80UCSlSvQe-TK_uOyDv_Jf], perhaps the best free deep learning theory course avaliable online.

## Polyak-Lojasiewicz condition

["Gradient methods for the minimisation of functionals"; B.T.Polyak](https://www.sciencedirect.com/science/article/abs/pii/0041555363903823)

Applied to deep learining by the paper ("On the exponential convergence rate of proximal gradient flow algorithms"; Hassan-Moghaddam and Mihailo R. Jovanovic)[https://viterbi-web.usc.edu/~mihailo/papers/mogjovCDC18a.pdf#:~:text=The%20Polyak-Lojasiewicz%20%28PL%29%20condition%20is%20an%20inequality%20that,is%20a%20twice%20differentiable%20function%20with%20a%20Lipschitz]

### Zero training loss regimes

PL condition always holds when training loss goes to zero


## Lipschitz continuity

All neural networks (with finite valued weights) are [Lipschitz continuous](https://en.wikipedia.org/wiki/Lipschitz_continuity).

[Picard–Lindelöf theorem](https://en.wikipedia.org/wiki/Picard%E2%80%93Lindel%C3%B6f_theorem#Proof_sketch) shows that all Lipschitz continuous functions have a unique solution to the initial point problem, so gradient descent with infintensimal updates are guarenteed to converge.

### Condition number of a matrix

(Condition number)[https://en.wikipedia.org/wiki/Condition_number]

*numerator of the condition number is the spectral norm*

#### Numerical stability of linear methods
#### Condition number and overfitting

*high condition number implies a certain sort of overfitting* 

### Calculating Lipschitz constant

Calculating a upper bound of the Lipschitz constant.

*add scipy code to calulate this upper bound easily*

### Spectral normalization

GAN stability can be aided by simply normalizing each matrix in the discriminator by the spectral norm bounding the Lipschitz constant of the discriminator to 1.

("Spectral Normalization for Generative Adversarial Networks"; Miyato, Kataoka, Koyama, Yoshida )[https://arxiv.org/pdf/1802.05957v1.pdf]·

Isn't used in supervised learning, slows training and doesn't help end performance.

### Batch normalization

Batch normalization lowers *emperical condition number* of each layer in the network, by linearly rescaling all actual inputs and outputs onto the same scale and same mean value.

Take fixed data input/output pairs $$ \{((a_1, z_l),...,(a_n, z_n)\} $$, and matrix *M* fit to minimize $$ \sum_i^n (Ma_i - z_i)^2 $$.

Now apply batch normalization to the inputs and outputs, to get:

* input scale vector $$ \alpha_a = \sqrt{\sum_i a_i^2} $$ (where everything is evaluated element-wise)
* input offset vector  $$ \beta_a = \sum_i a_i $$
* output scale vector $$ \alpha_b = \sqrt{\sum_i b_i^2} $$ (where everything is evaluated element-wise)
* output offset vector  $$ \beta_b = \sum_i b_i $$

And fit a new matrix to minimize $$ M^\prime =  \sum_i^n (M^\prime((a_i - \beta_a) \odot \alpha_a)  - (z_i - \beta_z) \odot \alpha_z)^2 $$ (where $$ \odot is the Elementwise product or  [Hadamard product](https://en.wikipedia.org/wiki/Hadamard_product_(matrices)))

For a hand-wavy argument to why batch normalization can improve the conditioning of the problem, consider the emperical condition number of the data:

Emperical condition number: 

$$ \max_{i,j} \frac{|a_i|}{|z_i|}\frac{|a_j|}{|z_j|} = \max_{i} \frac{|a_i|}{|z_i|} \max_j \frac{|a_j|}{|z_j|} $$

Batch normalized emperical condition number: 

$$ \max_{i,j} \frac{|(a_i - \beta_a) \odot \alpha_a|}{|(z_i - \beta_z) \odot \alpha_z|}\frac{|(a_j - \beta_a) \odot \alpha_a|}{|(z_j - \beta_z) \odot \alpha_z|} =  \max_{i}\frac{|(a_i - \beta_a) \odot \alpha_a|}{|(z_i - \beta_z) \odot \alpha_z|} \max_{j}\frac{|(a_j - \beta_a) \odot \alpha_a|}{|(z_j - \beta_z) \odot \alpha_z|} $$

Handwavy argument for why this improves condition number:

Note that bad conditioned examples in the original dataset would no longer be badly conditioned in the normalized dataset, as the small norm vectors would likely no longer be small due to the offset, and the large norm vecotors previously will no longer have a large norm due to the scaling.

Batch normalization is much cheaper to evaluate than spectral normalization, and works much better for supervised learning, since it works on both the numerator and denominator of the condition number, rather than just the numerator. However, the dynamics of how these weights are updated can be problematic, especially in adversarial regimes, and it doesn't help if the values are already well conditioned.

## Overparameterization

### Double minima

(Reconciling modern machine learning practice and the bias-variance trade-off; Belkin, et al. 2019)[https://arxiv.org/abs/1812.11118]

### Double descent example in linear models

Explain main theorem from:

https://youtu.be/75n2BIILNMc?list=PLHgjs9ncvHi80UCSlSvQe-TK_uOyDv_Jf&t=3994

### Determining overparameterization

Following summary guidelines for practitioners:

* Overparamertization is a critical property to the generalization success of deep models.
* In an overparameritized regime, wider layers is *always* better. 

Thus inspiring the following debugging technique:

1. Does increasing number of parameters (in particular width of network layers) improve or harm performance?
2. If not, then you are not in the overparamertized regime, and something is very wrong.

### Neural Tangent Kernel

Neural network $$ f $$ with parameters $$ \theta $$ evaluated on input $$ x $$ is $$ f(\theta, x) $$

Then first order taylors approximation is 

$$ \nabla_\theta f(\theta)(x) = f(x,\theta_0) + \nabla f(x, \theta_0) (\theta - \theta_0) $$

Note that 

