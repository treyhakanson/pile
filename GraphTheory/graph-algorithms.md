# Graph Algorithms (Ch 22-26)

* Adjacency Lists - good for sparse graphs
* Adjacency Matrices - good for dense graphs

## Exercises

**22.1-1** *Given an adjacency-list representation of a directed graph, how long does it take to compute the out-degree of every vertex? How long does it take to compute the in-degrees?*

out-degree: |V|
in-degree:  |V^2|

**22.1-2** *Give an adjacency-list representation for a complete binary tree on 7 vertices. Give an equivalent adjacency-matrix representation. Assume that vertices are numbered from 1 to 7 as in a binary heap.*

```
[/* 1 */ [2, 3],
 /* 2 */ [4, 5],
 /* 3 */ [6, 7],
 /* 4 */ [],
 /* 5 */ [],
 /* 6 */ [],
 /* 7 */ []]
```

## Breadth First Search
