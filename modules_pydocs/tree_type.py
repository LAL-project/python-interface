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

- ``bistar`` Bi-star trees

	These trees have two vertex hubs, \f$h_1\f$ and \f$h_2\f$, which are the
	only vertices that can have degree \f$\ge 2\f$.
	- If :math:`deg(h_1) = 1` then the tree is an instance of a lal.graphs.tree_type.star tree.
	- If :math:`deg(h_1) = 2` then the tree is an instance of a lal.graphs.tree_type.quasistar
	tree.

- ``quasistar`` Quasi star trees

	A @ref lal.graphs.tree_type.bistar tree where :math:`deg(h_1) = 2:. These are a specific instance of lal.graphs.tree_type.caterpillar trees and lal.graphs.tree_type.spider trees.

- ``star`` Star trees

	A @ref lal.graphs.tree_type.bistar tree where :math:`deg(h_1) = 1`. These are a specific instance of @ref lal.graphs.tree_type.quasistar trees, lal.graphs.tree_type.caterpillar trees and lal.graphs.tree_type.spider trees.

- ``spider`` Spider trees

	A tree where one vertex (the hub) has degree :math:`\ge 3` and the rest have degree :math:`\le 2` [1] [3]. This type of trees have as particular instances:
	- lal.graphs.tree_type.star tree
	- lal.graphs.tree_type.quasistar tree

- ``two_linear`` 2-linear trees.

	Trees that have exactly two vertices of degree \f$\ge 3\f$ [4]. Equivalently, these trees are two lal.graphs.tree_type.spider trees whose hubs are joined with a lal.graphs.tree_type.linear tree by the hubs.
	
	These trees have as specific instance lal.graphs.tree_type.bistar trees, but not lal.graphs.tree_type.star or lal.graphs.tree_type.quasistar trees.

- ``unknown``

	Used when a tree does not fall in any of the categories above.

References
----------

.. [1] Bennett, Patrick and English, Sean and Talanda-Fisher, Maria. Weighted turán problems with applications. *Discrete Mathematics*, 342(8):2165–2172, 2019. https://doi.org/10.1016/j.disc.2019.04.007.

.. [2] Frank Harary and Allen J. Schwenk. The number of caterpillars. *Discrete Mathematics*, 6:359–365, 1973. https://doi.org/10.1016/0012-365X(73)90067-8.

.. [3] Spider Graph -- Wolfram Math World. https://mathworld.wolfram.com/SpiderGraph.html. Accessed: 2022-10-04.

.. [4] Wakhare, Tanay and Wityk, Eric and Johnson, Charles R. The proportion of trees that are linear. Discrete Mathematics, 343(10):112008, 2020.

"""
