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
 *     Lluís Alemany Puig (lluis.alemany.puig@upc.edu)
 *         LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
 *         CQL (Complexity and Quantitative Linguistics Lab)
 *         Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
 *         Webpage: https://cqllab.upc.edu/people/lalemany/
 *
 *************************************************************************/

%module graphs

%include std_vector.i
%include std_pair.i

%include documentation.i

%import enums/tree_type.i

%import types.i

%{
// C++ includes
#include <sstream>

// lal includes
#include <lal/graphs.hpp>
%}

// making lists of graphs...
%template (_vector_undirected_graph) std::vector<lal::graphs::undirected_graph>;
%template (_vector_directed_graph) std::vector<lal::graphs::directed_graph>;
%template (_vector_free_tree) std::vector<lal::graphs::free_tree>;
%template (_vector_rooted_tree) std::vector<lal::graphs::rooted_tree>;

// making pairs of graphs and node...
%template (_pair_free_tree_node) std::pair<lal::graphs::free_tree, lal::node>;

namespace lal {
namespace graphs {

	%ignore graph::graph(graph&&) noexcept;
	%ignore graph::operator= (const graph&) noexcept;
	%ignore graph::operator= (graph&&) noexcept;

	%ignore undirected_graph::undirected_graph(undirected_graph&&) noexcept;
	%ignore undirected_graph::operator= (const undirected_graph&) noexcept;
	%ignore undirected_graph::operator= (undirected_graph&&) noexcept;

	%ignore directed_graph::directed_graph(directed_graph&&) noexcept;
	%ignore directed_graph::operator= (const directed_graph&) noexcept;
	%ignore directed_graph::operator= (directed_graph&&) noexcept;

	%ignore tree::tree(tree&&) noexcept;
	%ignore tree::operator= (const tree&) noexcept;
	%ignore tree::operator= (tree&&) noexcept;

	%ignore free_tree::free_tree(undirected_graph&&) noexcept;
	%ignore free_tree::free_tree(free_tree&&) noexcept;
	%ignore free_tree::operator= (const free_tree&) noexcept;
	%ignore free_tree::operator= (free_tree&&) noexcept;

	%ignore rooted_tree::rooted_tree(directed_graph&&) noexcept;
	%ignore rooted_tree::rooted_tree(rooted_tree&&) noexcept;
	%ignore rooted_tree::rooted_tree(free_tree&&, const node) noexcept;
	%ignore rooted_tree::rooted_tree(free_tree&&, const node, const bool) noexcept;
	%ignore rooted_tree::rooted_tree(free_tree&&, const node, const bool, const bool) noexcept;
	%ignore rooted_tree::operator= (const rooted_tree&) noexcept;
	%ignore rooted_tree::operator= (rooted_tree&&) noexcept;
	%ignore rooted_tree::init_rooted(free_tree&&, const node) noexcept;
	%ignore rooted_tree::init_rooted(free_tree&&, const node, const bool) noexcept;
	%ignore rooted_tree::init_rooted(free_tree&&, const node, const bool, const bool) noexcept;

} // -- namespace graphs
} // -- namespace lal

// -------------
// graph classes

%include "lal/graphs/graph.hpp"
%include "lal/graphs/undirected_graph.hpp"
%include "lal/graphs/directed_graph.hpp"

%include "lal/graphs/tree.hpp"
%include "lal/graphs/free_tree.hpp"
%include "lal/graphs/rooted_tree.hpp"

// -------------------------
// Extendind the C++ classes

namespace lal {
namespace graphs {

	%extend undirected_graph {
		std::string __repr__() const noexcept {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
		undirected_graph clone() const noexcept {
			return *$self;
		}
	}

	%extend directed_graph {
		std::string __repr__() const noexcept {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
		directed_graph clone() const noexcept {
			return *$self;
		}
	}

	%extend rooted_tree {
		std::string __repr__() const noexcept {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
		rooted_tree clone() const noexcept {
			return *$self;
		}
	}

	%extend free_tree {
		std::string __repr__() const noexcept {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
		free_tree clone() const noexcept {
			return *$self;
		}
	}

} // -- namespace graphs
} // -- namespace lal

%include "lal/graphs/conversions.hpp"

/* ---------- CALL from_edge_list_to_graph ------------- */

%pythoncode %{

def from_edge_list_to_graph(gtype, edge_list, norm = True, check = True):
	r"""
	Converts an edge list into a graph. This list consists of all the graph's
	edges. Each edge is described as a pair of indices of the nodes at each end
	of the edge. Nodes are labelled with indices starting at 0. The resulting
	number of nodes of the graph will be the maximum index in the file plus 1.
	
	Parameters
	----------
	* `gtype` :
		A string that encodes the type of graph. Must be one of:
		
		- free_tree
		- rooted_tree
		- undirected_graph
		- directed_graph
	
	* `edge_list` :
		The list of edges of the graph.
	
	* `norm` :
		Is the graph to be normalised?
	
	* `check` :
		If the graph is not to be normalised check whether or not the graph read is normalised.
	
	Returns
	-------
	A graph object of the same type as the string `gtype`
	"""
	
	if gtype not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "from_edge_list_to_" + gtype ](edge_list, norm, check)
%}

%pythoncode %{
__types = types
del types
%}
