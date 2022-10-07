r"""
The different types of trees.

- ``empty`` Empty tree.

	A tree with no vertices at all.

- ``singleton`` Singleton tree.

	A tree of a single vertex.

- ``caterpillar`` Caterpillar trees

	These are the trees such that a linear tree is produced when its leaves are removed [2].

- ``linear`` Linear trees

	A linear tree has only two leaves, and the rest of the vertices have degree exactly two. This is, precisely, a path graph.

- ``twolinear`` 2-linear trees.

	A 2-linear tree is a tree in which there are at most two vertices of degree 3 or larger; the other vertices have degree 2 or 1 [4].
	
	It can also be seen as the connection of two independent trees :math:`T_1` and :math:`T_2` where each tree is either a spider tree or a linear tree. If one of :math:`T_1` or :math:`T_2` is a spider tree, the path must be incident to the spider's hub vertex.

- ``spider`` Spider trees

	A spider tree has a unique vertex of degree greater than or equal to 3. The other vertices have degree 2 or 1 [1], [3].

- ``star`` Star trees

	Also star graphs, trees where all vertices but one have degree 1.

- ``quasistar`` Quasi star trees

	Also quasi star graphs, trees where all vertices but two have degree 1. One of these two vertices has degree exactly two, the other has degree at least two.

- ``bistar`` Bi-star trees

	These trees are made of two star trees joined by an edge at their centers.

- ``unknown``

	Used when a tree does not fall in any of the categories above.

References
----------

.. [1] Bennett, Patrick and English, Sean and Talanda-Fisher, Maria. Weighted turán problems with applications. *Discrete Mathematics*, 342(8):2165–2172, 2019. https://doi.org/10.1016/j.disc.2019.04.007.

.. [2] Frank Harary and Allen J. Schwenk. The number of caterpillars. *Discrete Mathematics*, 6:359–365, 1973. https://doi.org/10.1016/0012-365X(73)90067-8.

.. [3] Spider Graph -- Wolfram Math World. https://mathworld.wolfram.com/SpiderGraph.html. Accessed: 2022-10-04.

.. [4] Wakhare, Tanay and Wityk, Eric and Johnson, Charles R. The proportion of trees that are linear. Discrete Mathematics, 343(10):112008, 2020.

"""
