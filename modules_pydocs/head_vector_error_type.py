r"""
The different types of errors that can be present in a head vector.

- ``invalid_integer'' : The current head index is not a valid non-integer integer number. It could be a letter, a negative number, ...

- ``head_out_bounds'' : The current head index is a valid non-negative integer value, but points outside the head vector.

- ``wrong_number_of_roots'' : The head vector contains too many roots.

- ``wrong_number_of_edges'' : The graph does not contain enough edges to be a tree.

- ``graph_has_cycles'' : The graph contains an undirected cycle, that is, the graph is not a tree.

- ``isolated_vertex'' : There are isolated vertices in the graph.

- ``self_loop'' : The current head index points to itself.
"""
