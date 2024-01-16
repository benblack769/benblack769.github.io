---
title: "Hashlife w/webassembly"
slug: robotics-project
under_construction: false
excerpt: "A simple, effective hashlife algorithm in rust and viewer in javascript/webassembly. "
comments: false
share: false
post_date: "2023"
img: /images/hashlife/hashlife_splash.png
priority: 0
---

Awhile ago, I wanted to play around with web-centric computing using webassembly and rust. For a project, I picked out the hash-life algorithm an unintuitive fast and powerful algorithm for simulating Conway's Game of life. 

The app looks like this (<a href="https://benblack769.github.io/hashlife-rust/" target="_blank" rel="noopener noreferrer">click to go to deployed demo!</a>):

<a href="https://benblack769.github.io/hashlife-rust/" target="_blank" rel="noopener noreferrer">
![screenshot](/images/hashlife/full_app_screenshot.png)
</a>

To test the full power of the hashlife algorithm, I would recommend:

1. "Select builtin pattern" and selecting either "twinprimes.rle"
2. Pressing both "fast-forward" button and the "skip" button a few times
3. Increasing the brightness to the max
4. Waiting for a few seconds.

You should see the results look something like this:

![twinprimes-screenshot](/images/hashlife/twinprimes.png)

Note that the dots coming out of the machine correspond one to one with the twin primes! This machine is a prime sieve! 

Code here: https://github.com/benblack769/hashlife-rust
