# Semigeneric Computations

The code here was used in some computations in [CITATION]. It is mostly used for computing various combinatorial properties of the directed graph S, which is the smallest semigeneric directed graph on 3 columns that has all non-empty column divisions.

This repository contains 3 things:

1. `3_Column_methods.sagews`
2. `automorphisms.txt`
3. `transversals.txt`

## 1. 3_Column_methods.sagews

This contains all the relevant code, written in Sage. It can be compiled for free, at [CoCalc.com](https://cocalc.com/) for example.

It is broken up into 4 independent sections:

1. **The graph on 3 columns**. Here we define S, and display it nicely.
2. **Transversals**. This is the machinery for producing transversals in S.
3. **Type of a point**. This identifies the type of a vertex. This is not used in the paper.
4. **Automorphisms**. This is the machinery for producing automorphisms of S.

## 2. automorphisms.txt

This is a list of all 48 automorphisms of S. The format of each automorphism is a list of length 12, where the i-th element of the list is where the automorphism sends i. For example:

> `(4, 5, 6, 7, 2, 3, 0, 1, 8, 10, 9, 11)`

This text document is the output of the function `all_automorphisms()`.

### 3. transversals.txt

This is a list of all 48 linear transversals of S, that is, a subgraph that chooses exactly one vertex from each column and has a vertex with out-degree 2, and another with in-degree 2. The format of each transversal is a list of length 3, which orders the vertices as first the vertex with out-degree 2, then the one with out-degree 1, then the one with in-degree 2. In other words, it's ordered from smallest to largest (in the sense that the transversal can be thought of as a linear order). For example: 

> `(1, 11, 4)`

This text document is the output of the function `all_transversals()`.
