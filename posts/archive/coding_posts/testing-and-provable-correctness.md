## Why learn to test?

When I first learned about testing, I was very confused and anxious about what was expected of me. At some times, I worked too hard, testing many cases that more experienced engineers would have ignored. Of course, that means that when I was under time pressure, I failed to write more important tests, and implement other important features, i.e. I failed to do my job well. Other inexperienced coders are too carefree about their testing, and run into trouble later when complexity inevitably starts piling up. As I gained some experience writing tests, I learned how much subtlety and complexity there is to good testing. I do not yet claim to be a master tester, but hopefully my advice can be of help.


Now, most of the time, you can always ask other engineers what sorts of tests they expect for the type of code you are writing. Most likely, they have encountered something like it before, and you can learn a lot like that. This is the only path if you need to get something done immediately.

However, gaining additional subtlety and mastery of testing is crucial to becoming a great programmer. Great programmers have really


### Difficulty of testing

Testing is clearly important, and difficult. Some software engineers I have met had a saying:

> Coding is the easiest part of your job. The hardest part is testing, followed by design.

I think this idea really brings out the fact that code, especially more complex code, is often simple: it is often just joining a bunch of different packages together, with some small amount logic of your own. However, the tests actually have to get more complex, as  the number of possible cases increases exponentially, and the number of cases important to test also increases quite quickly.

#### Different kinds of testing

One difficulty of testing is that it is hard to even know what general class of tests you might want to implement. I'll go through the different main  kinds of tests, and give some non-obvious examples of the correct kind of test.

So in traditional software engineering, there are three main kinds of tests

* Unit tests: Test some kind of logic at the module level. This means it never depends on any outside processes such as internet services, databases, or significant pieces of immature code. Ideally, it doesn't depend on anything other than the standard library.
* Integration tests: This specifically tests the connection between your code and outside services, databases, and other software and hardware resources.
* End-to-end tests: This makes sure that user input generates the correct user level output, with the goal of making sure that the user experience is perfect.

Then each of these have special kinds of tests. For example, regression tests are a special kind of end to end test which assumes that some specific version of the software works correctly. And there are kinds of unit tests which take too long to run to be called good traditional unit tests, so people give them a different name. Then there are a couple of types, like performance tests, which really don't fit in any of these categories, but aren't important enough to include.

So with all these kinds of tests, what kind of test to focus on is not obvious.

* Unit tests vs regression tests:
* Unit tests vs integration tests
*

#### Dealing with change

*Managing change in tests is harder than software*

#### Code design considerations

*Testing impacts design choices, which makes things harder*


### My design philosophy of tests

*Tests are about establishing that your software is correct, meaning it works as designed. And designs should ???????????????????*

o
