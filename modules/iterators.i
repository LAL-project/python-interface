/**************************************************************************
 *
 * SWIG-generated python wrapper for the Linear Arrangement Library
 * Copyright (C) 2021 - 2024 Lluís Alemany Puig
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 * Contact:
 *
 *     Lluís Alemany Puig (lalemany@cs.upc.edu)
 *         LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
 *         CQL (Complexity and Quantitative Linguistics Lab)
 *         Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
 *         Webpage: https://cqllab.upc.edu/people/lalemany/
 *
 *************************************************************************/

%module iterators

%import types.i
%import graphs.i

%include documentation.i

%{
#include <lal/graphs.hpp>
#include <lal/iterators.hpp>
%}

%include "lal/iterators/E_iterator.hpp"

namespace lal {
namespace iterators {

%template(E_iterator_directed_graphs) E_iterator<lal::graphs::directed_graph>;
%template(E_iterator_undirected_graphs) E_iterator<lal::graphs::undirected_graph>;
%template(E_iterator_rooted_tree) E_iterator<lal::graphs::rooted_tree>;
%template(E_iterator_free_tree) E_iterator<lal::graphs::free_tree>;

} // -- namespace iterators
} // -- namespace lal

%include "lal/iterators/Q_iterator.hpp"

namespace lal {
namespace iterators {

%template(Q_iterator_directed_graphs) Q_iterator<graphs::directed_graph>;
%template(Q_iterator_undirected_graphs) Q_iterator<graphs::undirected_graph>;
%template(Q_iterator_rooted_tree) Q_iterator<graphs::rooted_tree>;
%template(Q_iterator_free_tree) Q_iterator<graphs::free_tree>;

} // -- namespace iterators
} // -- namespace lal

%pythoncode %{
def E_iterator(g):
	r"""
	Returns an iterator-like object that iterates over the list of edges
	of the input graph `g`.
	
	Parameters
	----------
	* `g` :
		Input graph.
	"""
	
	__full_type = str(type(g))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % __type_graph)
		return None
	
	return globals()[ "E_iterator_" + __type_graph ](g)

def Q_iterator(g):
	r"""
	Returns an iterator-like object that iterates over the list of pairs
	of independent edges the input graph `g`.
	
	Parameters
	----------
	* `g` :
		Input graph.
	"""
	
	__full_type = str(type(g))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % __type_graph)
		return None
	
	return globals()[ "Q_iterator_" + __type_graph ](g)
%}

%pythoncode %{
__types = types
del types

# remove unnecessary modules
del graphs
del tree_type
%}
