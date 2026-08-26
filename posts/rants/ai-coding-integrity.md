---
title: Agentic coding with integrity
under_construction: true
excerpt: "Agentic coding can lead to new levels of productivity, but also new hazards, and need hazard frameworks to constrain their activity in high-impact domains."
comments: false
share: false
post_date: "2026"
---

Coding agents ship code at a high rate that prevents thorough review of each line of code. Luckily, this isn't a new situation, since the 90s, companies have had trust issues with teams of low-skill developers or contract developers that they don't trust and don't expect great things from every time. We can adapt these principles to the modern world.

## Risk levels

In a software system, there are different types and levels of risk. Of course, this is application-specific, but I'll lay them as generically as possible:

1. Irreversible harm: Identity/Crediential theft, critical data loss, over-billing errors, medical device errors, hardware drivers leading to mechanical distruction, criminal legal liability, etc.
2. Recoverable harm: Buisness-impacting service disruptions/bugs, under-billing, recoverable data loss, single-customer legal action, civil legal liability, major certification failures, etc.
3. User trust harm: Visual ugliness, bugs with workarounds, gaps in support, non-critical system outages, non-critical certification audit findings

Then of course there are impact levels.

1. Whole/part of buisness: Can destroy the whole buisness/all users impacted
2. Single non-core product/user: Can destroy a significant fraction of the buisness/subset of users impacted

Risk frameworks often sum these two levels together and identify categories of overall risk based on that sum. 

* Score 2: Your buisness is dead in the water, and you are possibly in jail
* Score 3: Your buisness just took a 5-30% hit on the stock price, and you'll be experiencing the pain of the failure, loss in trust, possibly legal battles, etc, for at least a year.
* Score 4: You lost an important opportunity, but you'll be back up on your feet shortly. Take concrete action to address the underlying caude
* Score 5: Do a retro and root cause analysis to see if greater risks are there, but no need to take concrete action

## Code Ownership

The strategic way to limit the damage AI risk can do is with strong code ownership models. Yes, this means old-school gating of who can commit code and how. Yes, this means lower tier teams will be blocked by higher teir teams to make core changes.

* Teir 1 system: Critical system integrity: Data backups, password/PII protection, safety mechanisms. **Senior team with proven experience only. Every line of code must be understood by multiple team members. Every dependency reviewed regularly, every dependency update reviewed by hand.**
* Teir 2 system: Critical system stability: Autoscaling, SQL queries, failover, retries, vendor API calls, logging: **Credentialed teams, possibly with junior members assisting on the margins. Agent code reviewed by hand, possibly with agentic review assistance. Dependencies reviewed by automated systems.**
* Teir 3 system: Non-critical systems/UI: **Farm it out to Agents/Contractors as you please, but run it through some testing/QA before it deploys. Agentic code review only.**
* Tier 4 system: Untrusted code: **Great for live, user-facing LLM features or turing complete code execution as a service.**

## Team organization


