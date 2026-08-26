---
title: Builders need AI, not Operations
under_construction: true
excerpt: "Operations need reliabilty, repeatability, and efficiency --- three things that classical software was good at that AI is not as good at. The one thing they lacked with classical software was builders capable and cheap enough to build that software for them."
comments: false
share: false
post_date: "2026"
---

With the advent of generally intelligent AI agents, the question becomes: What is the best tasks to put them towards?

The answer is **Building**

* Building software tools
* Building custom reports/analysis
* Building plans/processes
* Building media content

Where AI is struggling, and where classical software is still dominating is **Operations**:

* Running a buisness (Accounting/Finance/Management)
* Supply chain/parts tracking
* Sales management (tracking leads/customers)

Just because AI demos well in these environments, does not mean it performs well in practice. The smartest, most powerful LLMs in the world that are transforming buisnesses in builder-land, are making critical errors, are slow, and costing huge sums of money in operations-land

### Example case: LIS workflows

I am currently building an Laboratory Information System (LIS) for clinical medical laboratories, and we came into this thinking that AI would be part of many features of the system. We have found ourselves pulling out AI feature after AI feature, replacing them with deterministic systems, which are faster, more reliable, and more power-user friendly (even if with a steeper learning curve)

#### Operational workflows we keep pulling out AI features from 

* **Voice agents:** We have slowly replaced each LLM-powered feature of our voice-drive application with an equivalent deterministic ruleset ---- thousands of lines of word lists and grammar rules that are 20x faster and slowly becoming more reliable and repeatable than an LLM. There's only final QA left, and even that will likely be replaced by deterministic systems
* **User-facing configuration managment:** Our configuration sets are very, very complex, and there's a very steep learning curve to modifying them. We tried to put AI agents in front of it for users, but fundamentally, it was still slow, still hard to grasp, and still unworkable to get most users comfortable with it. So we put simpler, less feature-rich layers of intutive UI interfaces beyond a subset of the configuration, and have them work with real humans to build more complex workflows if needed.
* **Quality Checks:** We've started replacing more and more of the quality process with deterministic, configurable rules --- these are more interpertable, more reportable, and quickly becoming more accurate than an LLM which truely doesn't understand the domain nearly as well as people on the ground. Not to mention being much cheaper
* **User training:** Traditional user training tools still work --- help tooltips, feature search, interactive tutorials, cheat-sheets, videos, etc, are far faster, friendlier, and more efficent to use than a chat window 95% of the time. AI's job is to help build the trainings in advance, not try to build them live, custom for each user.

#### Builder workflows where we find AI more invaluable the more its used

* **Core software development:** Writing code with AI in 2026 is a completely different experience than writing code by hand. And when architected with code *replacibililty* in mind, rather than *reusability*, it is a much better experience, especially for the replacible parts of the system: UI widgets, simple backend API routes, hardware integrations, etc.
* **Admin assistants:** Agents given to admins to manage complex configuration --- unlike operational users, who need to insert their new configuration in seconds or they give up, buisness administrators have the time to make something good, and to talk with an AI agent, understand the complexity, and make it good. Their day to day workflow is much more like a developer's, where they are trying to build plans and projects.

