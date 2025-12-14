---
title: A Manifesto Against Prediction Markets
under_construction: true
excerpt: ""
comments: false
share: false
post_date: "2025"
---


Prediction Markets are a financial mechanism that allow people to profit monetarily from correctly guessing future events.

They hope to make the idea of "putting your money where your mouth is" an everyday occurrence by creating official FTC approved derivatives for every conceivable difference in opinion about future events. These derivatives are a binding contract describing a transfer of money conditional on the actual outcome, as arbitraged by neutral FTC officials.

While there are concerns with manipulation issues if these markets become too big, and there's already concerns about insider trading for the individuals involved in the actual circumstances of the events to be predicted. I'm not going to concern myself with these issues, as my concern is not that good money chases bad ideas (just call it gambling). Rather my concern is that *good ideas end up chasing bad money*.

### Over-determinism

Historical events are over-determined. This means that one particular event turning out as one particular idea predicts gives extremely little information as to whether that ideas is true or false. In fact, if its truly over-determined then the rational Bayesian update on the idea is typically zero. Here's how that works:

Normal Bayes rule works like this:

$$P(A | B) = \frac{P(B | A) P(A), P(B)}$$

Where *P(A)* represents your prior probability of your idea, *P(B)* represents the prior probability of the event, *P(B | A)* represents the additional probability of the event given your idea, and * P(A | B)* represents the amount of confidence you get that your ideas is true after the event occurs.

The problem is that in an over-determined situation, $$P(B) = P(B | A) = 1$$, so you get zero new information about your idea. To make this more clear, lets introduce the additional cause as a new variable *C*. 

$$P(A | B) = \frac{P(B | A \and C) P(A), P(B | C)}$$

Now, after the event, we learn about *C*, and we learn that *C* deterministically causes event *B* to occur no matter other circumstances, so $$ P(B | C) = P(B | A \and C) = 1 $$ and so we correctly do not adjust our understanding of *A*.

But here's the problem: What if we never learn about variable * C *, even after the event occurs? Then we are mistakenly updating our probability of * A *. And we are encouraged to do so, so we can use this idea * A * for future predictions.

2. These short term events that will be the bulk of these FTC derivatives are quite frankly a waste of mental energy

