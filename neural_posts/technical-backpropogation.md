---
title: Backpropagation explanation
under_construction: false
excerpt: "To me, the backpropagation algorithm seems simple until you have to work with it non-trivially. If approached from formal calculus, the math symbols obscure what is going on in the network. If approached from a connectionist intuition it is far to easy to miss details and let bugs slip through. This article tries to combine the two ideas, giving calculus interpretations of network level objects."
comments: true
share: true
---


![arg](/images/backprop/diagram-svg/diagram.pdf.svg)
![arg](/images/backprop/diagram-svg/whole-backprop.pdf.svg)

![arg](/images/backprop/diagram-svg/act-whole-backprop.pdf.svg)
![arg](/images/backprop/diagram-svg/diagram2.pdf.svg)
![arg](/images/backprop/diagram-svg/diagram3.pdf.svg)

$$\frac{\partial w}{\partial cost} = A * \frac{\partial O}{\partial cost}$$
