### Collaz function

The collaz sequence is this:

You choose $$f(1)$$ to be some number, and then
$$f(n) =
    \begin{cases}
		f(n-1)/2 & \text{if } f(n-1) \text{ is even},\\
		3f(n-1)+1 & \text{if } f(n-1) \text{ is odd}.
	\end{cases}$$

The collaz conjecture is that all choices of $$f(1)$$, $$f(n) = 1$$ for some $$n$$.

It is a fairly famous conjecture because it can be described to anyone with a decent grasp of algebra, and yet Paul Erdos, the most prolific mathematician of all time by paper count said: "Mathematics may not be ready for such problems."

How is this problem so hard? Why has it escaped all attempts at proof? The [Wikipedia page on the collaz conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture) describes a number of ideas and theories which have had some level of success at providing evidence for the conjecture. Computational techniques have shown that the conjecture holds for all numbers less than $$2^60$$. But all attempts at general proof have failed miserably.

One thing that modern mathematicians try to do once a problem foils all attempts at proof is to try to show that it is in fact unprovable. There are various ways things can be unprovable. One way is that it cannot be described appropriately by the set of axioms you try to apply to it. People call this "true outside of axioms," and many people think this is the reason why $$P \ne NP$$ has foiled attempts at proof. Independence of axioms is a serious issue in mathematics, that has been shown to be true for interesting problems like the continuum hypothesis.

No one thinks this is true for the collaz conjecture, however. The way in which people have reasoned about the difficulty of the collaz conjecture is a little different, and closer to computational ideas. The idea is that there are some things that if we can find a machine which spits out proofs various things, can be used to calculate things that we cannot actually calculate, like the halting problem. Since humans are also machines, this means that we cannot solve these problems generally either.



*This idea is commonly misinterpreted. I'll go through various misinterpretations .*

Mathematicians try to put things in general settings, and prove things using a set of tools which individually can be applied generally, and together, can prove the item at hand. This greatly simplifies difficult problems. However, since we know that this problem somehow evades generally, we can guess that this approach will never work. Instead, we may need to treat this conjecture like a computation, and prove it using a great deal of case-work using computers. This approach has seen great success in problems like the 4-color theorem, and is seeing serious application in advanced number theory of all sorts (all sufficiently advanced number theory has this general problem of uncomputable proofs).


But how do we view this collaz function as a computation? How are we going to find the cases which need to be reasoned about? How do we know that this approach might yield results?

To answer this quickly, we are going to model it using cellular automata. We are going to analyze how the elements in this automata interact. We hope that this will yield results because the collaz function always collapses relatively quickly, in roughly log time of its size. This suggests that the computations have some general patterns that we can reason about somehow. Perhaps we discover it resolves to some other function we know converges. Or perhaps there turn out to be a finite number of "bad" cases. Or perhaps we won't prove it generally, but can add more evidence, and increase the bound on numbers we know converge to 1.

### Cellular automata and the collaz function

Lets do this in base 4

0,1,2,3

computing multiplication by 3 is hard, since carry bits can go all the way across the number in a single step.

So instead, lets keep track of the carry bits separately. Then we can view each digit in base 4 as an interaction of just the previous state, and the current carry bit.

This can carry out multiplication by 3, but division by 2 and adding by 1 is harder. In order to do this, lets introduce a 5th state, $$k$$, that goes through and moves up to the lowest non-zero digit in base 2 (which can be easily modeled in base 4), and introduces cary states which supply the +1 value.

Doing this, using the syntax `(<previous value>,<previous carry>),(<value>,<carry>) -> <value,carry>`, we can build transition states for the cellular automata like this:

    (3,1),(2,1) -> (3,?)
    (k,0),(0,0) -> (k,1)
