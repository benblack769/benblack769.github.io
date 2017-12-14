# Math and Computer Science

Math and computer science have a long history together. Some of the biggest figures in Computer Science, including Alan Turing, Von Neumann, and Donald Knuth were PhDs in pure mathematics. This connection is not accidental. The work they were doing was all very serious mathematics, even if much of it looks like engineering today.

## Computer science needs math

And yet, in the 21st century, the increasing sophistication of tools and best practices have allowed many good computer scientists to not see the deep connections between the two subjects.

But I always believe that if you are a computer scientist, and you want to make meaningful conceptual contributions to the subject area, then a deep understanding of mathematics is essential. And even if you only wish to contribute more empirical and applied work, then I believe that mathematical skill is incredibly valuable.  


### Concept: Structured Reasoning

All purely conceptual work is primarily philosophy. This is pretty much by definition of what philosophy is, the study of things that other subjects do not have methods of studying. And like most fields of study, computer scientists like to think of conceptual gains as manna from heaven, rather than trying to study it. Philosophy does try to study this process, however. Discussion of what makes a good theory, and perhaps even how to go about constructing one is a feature of all good philosophy classes.

Interestingly enough, there is another field that attempts to study theory itself: Pure mathematics. In the 20th century, so many new mathematical theories started appearing, that there was serious work in understanding what separated out the useful ones from the useless ones. And any good mathematics researcher understands these principles. Now I am not a good mathematician, so I don't claim to be an expert about this, but I know people who do. And even the basics have completely changed my intellectual focus.

### Skill: Analysis of API properties

APIs (Application Programming Interfaces) are absolutely core to modern computer systems. Really, we couldn't do many of the things we take for granted with them. Without good APIs, we would not have full stack development. Every website would be a huge engineering effort, even small ones. Software as complicated as Facebook's website or Amazon's ordering system would be completely impossible without very high quality APIs.

However, a lot of engineers who I have met are actually really bad at developing good APIs. These are good people who really care about their user, who have strong technical skills, and good at working with a team. I think the reason why they are bad at APIs, despite otherwise being good engineers, is that they barely understand what a good API is, and don't know why good APIs are more useful than bad ones. And I think that math, especially pure math, can help.

So what is an API, what makes it good, and how does this connect to math?

#### What is an API?

An Application Programming Interface is pretty much what it seems. Here "Application" usually means arbitrary substantial software, so it is just an interface which allows you to use some substantial software programmatically.

So really, it is just a way to use code. One of the core ideas of an API is that it creates a barrier, a separation of code into two parts:

1. The service, or code which powers the API
2. The client, which uses the API to get something done

Note that the actual API itself is not the client or the server, rather, it is the contract between the two, the promises that the service guarantees when the interface is used.

From a software engineering standpoint, this allows you to divide the programmers into two parts, people who work on the service, and those who work on the client. Then they only need to talk to each other when the contract needs changing, otherwise, the client can rely on the promises of the contract, and the service can change underneath the hood as long as it keeps its promises.
This is referred to as an internal API if the same company employs programmers on both sides of the divide.
Sometimes the client is actually a client of the company, and they are literally purchasing the services that are provided. The cloud is based on this idea.

#### What makes an API useful?

An API has

#### How do good APIs connect with math?
