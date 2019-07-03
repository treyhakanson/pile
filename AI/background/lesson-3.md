Lesson 3

---

# Probability in AI

## Introduction to Probability and Bayes Networks

A Bayes Network is a compact representation of a distribution over a very large join probability distribution of all variables involved in a problem

Bayes networks are vital to smart software, and is a building block to more advanced AI techniques

- complimentary probability
  - `P(A) = p => P(¬A) = 1 - p`
  - if the probability of one outcome is p, the probability of the opposite outcome (denoted with ¬) is 1 - p
- independence
  - `X ⟂ Y : P(X)P(Y) = P(X,Y)`
  - if variables X and Y are independent of each other, then the joint probability of both occurring is the the product of the marginals
- total probability
  - `P(Y) = ∑P(Y|X=i)P(X=i)`
  - the probability of Y is the sum of the probability of Y given outcome X times the probability of outcome X for all possible outcomes i of X
- event negation
  - `P(¬X|Y) = 1 - P(X|Y)`
  - the probability of ¬X given Y is the probability of 1 - the probability of the opposite given Y
- Bayes Rule
  - `P(A|B) = (P(B|A) * P(A)) / P(B)`
    - where B is the evidence and A is the variable that is actually of interest
    - example would be B is a test, A is the chance of having a disease
    - P(A|B): posterior
    - P(B|A): likelihood
    - P(A): prior
    - P(B): marginal likelihood
  - P(B) is often expanded via total probability (see above)

## More on Bayes Rule

Remember to carry conditionals when applying Bayes rule:

```
P(A|B,C,D,E) = (P(E|A,B,C,D) * P(A|B,C,D)) / P(E|B,C,D)
```

## Bayes Networks

A bayes network is composed of a variable that is not observable (A), and a related variable that is observable (B). The likelihood of B is known for given A, and the prior is also known; from this, the diagnostic reasoning can be deduced, which is the probability of A given B or given ¬B

It takes 3 parameters to derive a bayes network; P(A), P(B|A), and P(B|¬A), from which all else can be derived

typically, P(A) is very easy to compute, but P(B) can be much more difficult

this potentially difficult calculation can be avoided by using a different normalization strategy:

```
P'(A|B) = P(B|A) * P(A)
P'(¬A|B) = P(B|¬A) * P(¬A)
P(A|B) = η * P'(A|B)
P(¬A|B) = η * P'(¬A|B)
where η is the new normalizer:
η = (P'(A|B) + P'(¬A|B)) ^ -1
```

tests (observable values used to gain insight into unobservable ones) in Bayes Networks are often conditionally independent, meaning that having information about one test does not change the probability of another test, under the assumption that the unobservable value is known:

```
P(T2|C,T1) = P(T2|C)
```

the tests are only independent under the condition that the unobservable value is known because if it is not, one would assume that one test showing positive would lead to a higher likelihood of another test showing positive. This is because if the value is not fully known, a test result can give further information that can then be used in determining the expected result of the next test.

conditional independence does not imply absolute independence, nor vice versa; the later is for complex reasons that are not fully understood.

A Bayes network can also be defined by multiple causes contributing to an unknown value, such as factors leading to happiness
    - in this case, the causes will not be related if they independently affect the unknown value
    - "Explaining Away" is a term used with these types of networks to deduce what cause is likely leading to an outcome, based on what is observable, assuming the previously unobservable value is known. For example, if someone is often happy if it is sunny or because they got a raise, and they are happy, checking to see if it was sunny could help determine the likelihood that the got a raise.
    - In such a network, although the known values are independent, the unknown value adds a conditional dependence between the two if it becomes known
        - aka in the absence of information about the unknown value, the known values are independent for this type of network; but if something is known about the unknown value, then a conditional dependence arises
        - independence does not imply conditional independence

The number of probabilities needed to define a Bayes network is determined by the network graph; each node in the graph requires `2^k` inputs to be defined, where `k` is the number of inputs
    - this means Bayes networks require significantly less parameters than if one were to naively approximate the number of parameters needed to specify the network; that would be `2^n - 1` where n is the number of variables

## D Separation or Reachability

- Any two variables are independent if they are not linked by only unknown variables
    - for example, if node A is known, all nodes downstream of A will be independent of all nodes upstream of A, because these nodes can no longer give any additional information into the value of A

### Active Triplets

When variables are dependent

⚪️ -> ⚪️ -> ⚪️

⚪️ <- ⚪️ -> ⚪️

- The first and last nodes above are dependent since the middle node is **not** known

⚪️ -> ⚫️ <- ⚪️

- The middle node in this case must be known in order for the first and last nodes to be conditionally dependent, since knowing information about this node allows for an inference to be made about the first and last nodes given one of their values

⚪️ -> ⚪️ <- ⚪️
      |
      V
      .
      .
      .
      ⚫️

- Similar to the previous, if a direct successor to the middle node is known, it will in turn provide information about the previous nodes, thus again leading to conditional independence of the first and last nodes

### Inactive Triplets

When variables are independent

⚪️ -> ⚫️ -> ⚪️

⚪️ <- ⚫️ -> ⚪️

- The first and last nodes above are independent since the middle node is known
    - This is referred to as "cutting off"

⚪️ -> ⚪️ <- ⚪️

- Not knowing the value of the middle not means that adding information about the first or last node gives no useful insight into the value of the other
