---
title: Machine Learning --- a Mechanic's Perspective
under_construction: true
excerpt: ""
comments: false
share: false
post_date: "2025"
---

## Mechanics, Craftsmen, and Architects

In every large engineering department you will see these two types of people -- the architects, typically at the top of the ladder, typically in lots of meetings, writing documents, creating diagrams and planning large coordinated efforts involving lots of people and systems. And you will see mechanics going around near the bottom of the ladder, fixing urgent issues with small, clever changes.

But this is just the surface. What is below the surface is a fundamental difference in attitude to system development vs human development.

* Mechanics main see systems get worse and worse as they develop and features are added. If any progress is made, it is in human's ability to work with simple, flexible systems, and adapt to them.
* Architects generally see systems getting better with more development, including more design and better abstractions. If there is any risk, it is in human mistakes during implementation or usage that break barriers intended in the design. 

Of course, it is when these two groups come together that the most amazing things are made. But if you get to choose one, or if your system does not have an 8 figure development budget or more, you always will want the mechanic alone. The mechanic is the one who is not only able to work under constrained resources, but is actually more motivated under harsh constraints. The mechanic is not only to abstract one user's need to apply to others, but to actually simplify the problem by understanding non-systematic ways to solve perceived needs, such as additional training that can be completed cheaply without system changes, or clever manual use of non-integrated external tooling by users. 

And in machine learning, especially deep learning, the mechanic has gotten sidelined by the architects, to the frustration of business leaders who wonder why their small machine learning projects are going over budget and under-performing. From what I've seen, this is partly because there simply aren't as many experienced mechanics in the field, due to its relative youth. And partly because the people who write and talk about machine learning developments and concepts are almost all architects, so this perspective and approach is disseminated much faster. 

I hope to help disseminate a mechanic-first approach to machine learning. I hope this both helps prospective ML mechanics know what to learn, and also architects know how to better support their mechanics.

## Mechanics vs Craftmen

There is another role here, the craftsman.

One of the problems with being an ML mechanic is that problems usually occur in production, very far downstream of development, and usually comes in the form of a nasty email that looks like: "System did bad thing". Will not use product and do everything manually instead as a mitigation until problem resolved."



## The ML Mechanic setup

Every mechanic needs a decent work setup to solve a hard problem. A car mechanic not only need the car, they need a whole set of tools, a good way to get under the car, open the hood etc. Then, they need the actual authority and time to take it apart and test parts of the car. One of the difficulties facing those who could be the next generation of ML Mechanics is one or more of these aspects are missing:

1. Missing/incomplete tooling
    * No clear way to grab metrics/visualizations
    * No clear way to visualize data 
2. Lack of access/visibility to certain layers of the system
    * black-box algorithms (especially over-reliance or excessive end to end dependence on these algorithms)
    * non-reproducible/undocumented model training processes
3. Authority to access/test parts individually 
    * Data access control
        * No access at all
        * No ability to clone data for abilation testing
    * Infrastructure access control
        * No access at all
        * No dev stack for testing
    * Proprietary software
        * No internal access at all (interface is severely confining)
        * No way to modify software for testing

Each of these deserves a more detailed discussion.




