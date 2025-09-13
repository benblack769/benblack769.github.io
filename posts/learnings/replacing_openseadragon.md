---
title: Optimizing OpenSeadragon
under_construction: true
excerpt: "An engineering team's adventurous journey to fight the dragons of complexity and ascent to the peaks of performance."
comments: false
share: false
img: ''
post_date: "2025"
priority: 1
---

In any optimization project, your path starts easy. Wandering through the fields towns, you make progress quickly, with fellow companions trying to optimize their own projects and publishing their insights and efforts online. The experience is easy and brisk, with a logical sequence of simple fixes involving little code or effort.

As you make progress, you move past the fields and towns ascend into the forests, where the bottlenecks aren't clearly identifiable, and the hills, where fixes are a bigger lift. The path becomes thinner, with fewer people taking the same path, and any documentation becomes more obscure and harder to understand. You start to encounter beasts: Biased and misleading benchmarks, latency-filled and incomplete monitoring tools, mind-bending architectural choices rearing their head in critical dependencies, and your own nasty house bugs that infect the increasing complex codebase you are building.

And finally, you make it to the peaks, peering your way through the blizzard, all alone, trying not to slip off into the chasm of a serious performance bug or regression. The beasts re-appear in front of you (if not dealt with conclusively). They have been evolved into dragons by the higher expectations and harsher standards, and can sweep the project into a chasm of despair. And from time to time, you can catch a a brief (and possibly illusory) glimpse at the stars of perfection through the clouds.

This is the story of such a journey. A simple start, a clear goal, and the adventures that ensued. 

### Phase 1: Setting off for the hills

The project starts with a simple, clear concept: *We need a fast whole slide image viewer*. Whole slide images are huge, gigapixel, multi-scale images that can be zoomed into to see fine detail, zoomed out to see large structures, and pan around to see the whole image which is much larger than the screen. Its very much like interacting with google maps. 

However, this simple start got rocky very fast when it came to specification and architecture: How fast is fast-enough? Are any existing slide viewers fast enough? Is it possible to build such a fast viewer with the architecture we wanted? People started throwing around numbers: Can humans notice the difference between 200ms latencies and 100ms latencies? The existing on-prem viewer is fast enough, and it gets tiles from the server in 20ms, is it necessary to replicate that network performance? 

Engineering management decided to handle this by leaking the specification mess to implementation engineers one twist at a time. At first there was a clear goal of: get down round trip movement->network-render round trip times to 200ms. Then when we started getting close to this, the bar raised to a 100ms target. Then we started hearing about some of the anxiety around 30-40ms draw times. 

However, this initial 200ms time goal turned out to not be too hard to meet. Setting up the network in a sane way proved not too difficult. Put the data in the same continent, ensure the images went over an HTTP2 stream so we didn't need to re-do the handshake each request, ensuring that the server was just a proxy and couldn't be CPU throttled, that the tile lookup tables were easy to parse and cached, and the system just kind of worked. We were getting tiles so much faster and more consistently, and the viewer was looking a lot better.


### Phase 2: Attack of the dragon of chaos

As soon as the network started giving us consistently fast responses, our next problem became clear.
* OSD changes
* Web workers
* More OSD Changes

We played around with edge network acceleration technologies like AWS cloudfront and AWS global accelerator. Both worked in some cases, and were slow in others. Direct connections offered low initial latencies struggled to provide maximum bandwidth to the client. Global accelerator was generally good on many networks, but some networks could not tolerate the jumbo packets. AWS Cloudfront had decent max bandwidth and was compatible with all networks, but had expensive and unmanageable cold-hot behavior as it scaled up and down client's connection to the edge.


### Phase 3: Building a base camp
* Zoomy API
* OSD Bridge
* Websockets

### Phase 4: Approaching the summit
* Composite textures
* Tile Blending
* GPU ICC Profiles
* Hardware insights (integrated vs discrete graphics)
* Performance bugs

### Phase 5: The dragon guarding the summit:
* Unobservable GPU contention
* Queue size estimation
