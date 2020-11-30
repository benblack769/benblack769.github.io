Why always try to maximize the expected value of policy?

By sometimes maximizing and sometimes minimizing a policy, perhaps a greater range of values can be seen, helping solve the [Value Curvature Problem](/#value_curvature_problem) by increasing variance and decreasing bias.

Idea to train policy to generate variety of values is to set a target value in advance, give it to the policy, and expect it to get exactly the value, penalizing it in either direction if the true value differs from the target value.
