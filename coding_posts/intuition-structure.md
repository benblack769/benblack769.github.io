---
title: "Intuition and structure: The story of code"
slug: intuition-structure
under_construction: false
excerpt: "Instrutive post about expressing ideas in code."
---

When I first started coding, I thought that coding was like other forms of engineering. You have a problem, some materials, and the challenge is to piece together the tools in a clever way to make a working solution. It is a pretty common thought, and not entirely wrong, either. Many libraries and frameworks are built with this methodology in mind. But I find it lacking.

The problem that finally forced me to work on this was a game I designed and wrote. When I first started writing it, it was almost all in a single 4500 line file, with several functions that were several hundred lines, with a dense coding style. If you want to laugh at some really bad code, you can find that file [here](https://gist.github.com/weepingwillowben/9f180dda531aed3249836efe12351033). I spent almost 2 years refactoring it and improving the AI, and ended up rewriting the whole thing around 3 times (you can see the latest version on [here](https://github.com/weepingwillowben/qtwargame)). But every time I was deeply unsatisfied. I was unsatisfied with my AI design, I was unsatisfied with my GUI, and I was unsatisfied with the abstractions my code had, and the additional burden they placed on me. And eventually I grew impatient enough, and the code difficult enough, that I abandoned the project. I just wasn't smart enough to solve the problems I needed to solve. And that made me sad.

So I set on a mission to figure out how to do better next time. I promised myself that the next time I would start on a project, I would not fail.

## The solution

It is common knowledge that the secret to dealing with complexity is to break it down into manageable components, and reason about each component separately. But implementing this in the wild is not necessarily easy. Two questions need to be answered.

1. What should the components should look like broadly?
    * Interfaces/APIs
    * Naming schemes
    * Abstraction level
2. How should you implement those in code?
    * Polymorphic types vs. instance files
    * Language (c++, python, Haskell, etc.)
    * Codebase issues (packages, install process, etc)

While the second one is super important, I don't have space to talk about it right now. Rather, I hope to convince you that you can reason the say way about the problems in \#1 no matter which way you handle \#2.

### What should the components should look like?

#### The standard answer

So when most people teach clean coding, they go talk about huge numbers of individual characteristics that it is good for code to have.

Here is a very incomplete list of characteristics people discuss when improving code (feel free to skim over this):

* Clear operations, internal structures
    * Functions/classes should have an explicit purpose (this purpose can be fairly abstract, but it should not change all the time)
    * Good usually means a clean, well defined API.
    * These are the building blocks of your code. If these aren't good, then everything will be ugly and annoying.
* Reusable code
    * Helper functions should be helpful to more than one use case
    * Classes should be extensible
* Clear variable names
    * Clarity of variable name scales with scope size (global variables are very clear even if that means they are verbose, variables in small loops can be short and ambiguous)
    * Someone who is reasonably familiar with the problem being solved should know what a particular variable is, even if they aren't familiar with the codebase.
* Separate each idea
    * If you can find further ideas within the original idea, separate that apart as well.
    * Minimal function input-output
* Testable
    * Tests should not break during refactoring
    * Only a few tests should break during feature changes
    * Unit tests should run fast, test small units of code
    * Minimal state injection
    * Minimal stubs/mocks

Unfortunately, it is very hard to learn how to apply all these different, contradicting ideas to code. Considering the messiness of real code, the time pressure people usually code under, the unknowns and constant changes of software engineering, and all the things I didn't mention in the above list, and it is no wonder that many people can code for years and never learn how to write good code.

#### My answer

Eventually I found a solution. It is not exactly an original solution, although I approached it with somewhat more energy than most, due to my rather painful way of arriving at it.

The solution is complex, but the concept is simple: **you shouldn't have to think too hard about code**. There is one exception to this, refactoring. [Another post of mine](coding_posts/refractoring) covers this.


#### Justification

If you believe my answer, you can skip to the next section. If not, then continue.

But despite that case, every one of the above bullet points can be reduced to this one line.

* Clear operations, internal structures
    * If your code's functions, classes, and modules have explicit purposes, with stated guarantees, edge case handling, etc, then you can write code on top of it without thinking about what the code actually does. Thinking about the operation of submodules is a huge pain when writing code.
    * Figuring out whether a function has been written yet or not can be a huge pain in larger codebases, so making sure your file hierarchy is laid out well is huge.
* Reusable code
    * You don't want to have to think about the same thing twice. So don't. Write code that solves one problem once. Use others code so you don't have to think about it yourself.
* Clear variable names
    * You don't want to have to remember what you were thinking when looking back at old code. Nor do you want others to try to guess what you were thinking.
    * When picking variable names, think: "If I forgot what I was thinking, would I remember it with this name?"
* Separate each idea
    * You don't want to have to juggle two ideas when you only need to juggle one. If you are thinking about two things when writing one piece of code, try to think about how to separate it as much as possible.
* Testable
    * You don't want to think hard about if tests passing imply that your code works. It should be really obvious, or your test is no good, and you should go write a test for your test.

Now, you might call foul on me here. A lot of code can't seem to meet this ideal, no matter how we might want it to. Lots of code is based on complex codebases we can't hope to change, and is bad due to that. Some code has difficult algorithms, or complex logic that we can't avoid. Sometimes, the effort is simply not worth it: after all, the end goal is to make something that works, not something that is easy to understand.

And for sure, holding different kinds of code to different quality standards is OK. Lots of production code has high standards for unit tests, so it can generally be messier at the unit level. Too much code reuse leads to monolithic software.

But note that none of these things really contradict the thesis. If you are checking accuracy via unit tests, then you don't have to look at it that often, so you have to think about it less, even if it is messier. Difficult algorithms being hard really has nothing to do with the code being hard: such algorithms should be documented outside the code, and the code only needs to be able to reflect that documentation, and pass the tests. So it is the algorithm that is difficult, not the code. Monolithic codebases requires you to know too much, so if your code is leading to that, then you aren't really following the spirit of the thesis.

#### Ideas

I will try to show how these ideas that form the basis of code readability are tied to our intuitions of the ideas, and also to mathematical structure. That way, perhaps you can figure out your own code problems.

The structure of your code needs to reflect the structure of the problem. After all, your code is in the end your design. Any sufficiently detailed and unambiguous description of a process is code. And any  So, the code should reflect the process as clearly and precisely as possible.

Imagine that you are telling a story to someone else with your code. The person doesn't know how to play tick tack toe, and your code will show them.

This is quite challenging, and I can't hope to teach this in a blog post. Rather I will try to show how to communicate these components in code.


## Examples

Examples are difficult because they aren't particularly meaningful unless the code is large and complex. The full benefit only becomes clear if you are constantly revisiting the code (another reason why many people never learn).

Examples at a high level architecture level are [in this cool book (not mine)](http://aosabook.org/en/index.html).

At a more moderate level, [my refactoring page](coding_posts/refractoring) has an interesting example.

So here I will cover a lower level.



<!--
Here is a relatively simple problem which should demonstrate this. The problem is that I know how to check if someone won in tick tack toe. Simple enough, right? You check the rows, columns, and diagonals, and see if a player occupies all the spots there. But this problem, and other similar to it haunted me for years afterwards, making my code error prone, and difficult to debug.

Below is some code that solves the tick tack toe problem. I wrote only a few weeks from when I learned programming for the first time. It represents the 9 boxes as 9 separate variables, box[1-9]. The box is 1 if the player has it, 10 if the computer has it, and 0 if it is empty. It then finds out who won (full code [here](https://gist.github.com/weepingwillowben/8786b84688936e206408d71ae040c18e), windows only unfortunately). It looks like this:

[code language="c"]

    num1 = box1 + box2 + box3;
    num2 = box4 + box5 + box6;
    num3 = box7 + box8 + box9;
    num4 = box1 + box4 + box7;
    num5 = box2 + box5 + box8;
    num6 = box3 + box6 + box9;
    num7 = box1 + box5 + box9;
    num8 = box3 + box5 + box7;
    if (num1 == 30 or num2 == 30 or num3 == 30 or num4 == 30 or num5 == 30 or num6 == 30 or num7 == 30 or num8 == 30)
    {
        cout << "COMPUTER WINS!\n";
        break;
    }
    if (num1 == 3 or num2 == 3 or num3 == 3 or num4 == 3 or num5 == 3 or num6 == 3 or num7 == 3 or num8 == 3)
    {
        cout << "PLAYER WINS!";
        break;
    }

[/code]

As you can see, I could code a solution with the tools I had at hand. And at the time, that was enough. But now, I realize that it is not very good. It has lots and lots of variables and arbitrary constants, which makes checking/debugging the code hard and slow. It is just about impossible to generalize to larger grids. Understandable for my first code, but lets try to do better.

The standard approach would be to iteratively refractor this, until it looks decent. We would put the numbered variables in an array, then loop over them, in some places, take out functions, etc, to make the code more concise and stuff. This is not a bad approach. But it can actually be harder than building it up again from scratch, and it is easier to make poor choices. So instead, lets try to think of things structurally, picking out what each part of the code really accomplishes, and build this up.

First, basic data structures. What is a tick tack toe board anyways? It is a grid that looks like this, right?

    X|O|S
    X|O|_
    O|X|O

We really only care about the rows, columns, and diagonals. If you trace your finger over the rows, columns and diagonals, you might notice that your finger seems to be moving quite freely over a 2 dimensional discrete space. This reveals that the base data structure needs two qualities, it needs to store discrete values. Luckily, there is already a standard solution to general discrete 2d movement, the 2d array.

    board = array[3][3];

Now, how do we represent the Xs, Os, and blanks? Again, think of what we they actually are, and what we need of them. They actually are symbols that represent something about the game. We need them to be distinct from each other, and to not allow for anything other than Xs, Os, and blanks. Here there are several options. Strongly typed enums have these qualities. But perhaps this is overkill, as they also have other guarantees, such as efficient use as a key, which we don't need. So lets make our own type that meets these conditions.



Ok, so that wraps up the data structure. Now we need to look at the tasks we ask of that data. These can be thought of as queries, or manipulations.

Here is a task. We want the user of the software to be able to choose a coordinate, and then set that to be the players symbol if it is not already chosen. If it is already chosen, then we want to change nothing, and tell the user that they need to choose something else.

Wow, that is a lot of requirements. And it is the thing that experienced coders can just crank out without thinking about it at all. So

Here is a more complicated task, the original one.

Lets take
-->


### Conclusion:

Some people often mistake good code with concise code. The two are definitely not the same. After all striving for conciseness and minimal code changes without thinking about the broader story is the source of spaghetti code and monolithic software.

Other people think the best code is readable code. But at the extremes, you end up with COBAL, perhaps the worst programming high level language that people actually used.

Other people think the same thing about testability, extensibility, maintainability, documentation, and more. All of them are super important in software, but focusing on these things individually leads to mistakes and poor tradeoffs. I find that if you just ask the question: *do I have to think about my code*, or when working with others, *will my collaborators have to think about my code* then that can, with experience, answer every question. And that is the best we can hope for.
