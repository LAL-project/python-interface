r"""
The different algorithms for chunking a syntactic dependency tree.

Chunking is the art of grouping nodes (a.k.a. words) of a syntactic dependency tree in such a way that the resulting groups share common properties. This enumeration lists all the chunking algorithms implemented in this library.

The algorithms available in this library are:

Anderson's algorithm
--------------------

See [1] and [2].

Value: ``Anderson``.

Mačutek's algorithm
-------------------

See [3].

Value: ``Macutek``. 

References:
-----------

.. [1] Mark Anderson. An Unsolicited Soliloquy on Dependency Parsing. PhD thesis, Universidade da Coruña, 2021. URL: https://ruc.udc.es/dspace/bitstream/handle/2183/28513/Anderson_Mark_TD_2021.pdf?sequence=1

.. [2] Mark Anderson, David Vilares, and Carlos Gómez-Rodríguez. Artificially Evolved Chunks for Morphosyntactic Analysis. In Proceedings of the 18th International Workshop on Treebanks and Linguistic Theories (TLT, SyntaxFest 2019), pages 133–143, Paris, France, 08 2019. Association for Computational Linguistics. https://doi.org/10.18653/v1/W19-7815.

.. [3] Ján Mačutek, Radek Cech, and Marine Courtin. The Menzerath-Altmann law in syntactic structure revisited. In Proceedings of the Second Workshop on Quantitative Syntax (Quasy, SyntaxFest 2021), pages 65–73, Sofia, Bulgaria, 12 2021. Association for Computational Linguistics.
"""
