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

%module linarr

%include std_vector.i
%include std_array.i
%include std_pair.i

%implicitconv lal::linear_arrangement;

%import types.i // this is necessary for the wrapper
%import enums/syntactic_dependency_tree.i
%import enums/algorithms_C.i
%import enums/algorithms_chunking.i
%import enums/algorithms_Dmin.i
%import enums/algorithms_Dmin_planar.i
%import enums/algorithms_Dmin_projective.i
// these are necessary for the wrapper
%import graphs.i
%import numeric.i
%import properties.i

%include documentation.i

%{
// C++ includes
#include <sstream>

// lal includes
#include <lal/graphs.hpp>
#include <lal/linarr.hpp>
#include <lal/properties.hpp>
%}

%template(pair_value_arrangement) std::pair<uint64_t, lal::linear_arrangement>;
%template(pair_list_value) std::pair<std::vector<uint64_t>, uint64_t>;
%template(pair_value_list_arrangements) std::pair<uint64_t, std::vector<lal::linear_arrangement>>;

%include "lal/linarr/aggregations/1level.hpp"
%include "lal/linarr/aggregations/2level.hpp"
%include "lal/linarr/C/C.hpp"
%include "lal/linarr/D/D.hpp"
%include "lal/linarr/D/Dmin.hpp"
%include "lal/linarr/D/DMax.hpp"
%include "lal/linarr/head_initial.hpp"
%include "lal/linarr/formal_constraints.hpp"

// ---------------
// Dependency flux

namespace lal {
namespace linarr {

	// ignore non-const
	%ignore dependency_flux::get_left_span() noexcept;
	%ignore dependency_flux::get_right_span() noexcept;
	%ignore dependency_flux::get_weight() noexcept;
	%ignore dependency_flux::get_dependencies() noexcept;

} // -- namespace linarr
} // -- namespace lal

%template(list_dependency_flux) std::vector<lal::linarr::dependency_flux>;

%include "lal/linarr/dependency_flux.hpp"

// -------------------------
// syntactic dependency tree

%template(array_of_bools_tree_structure_type) std::array<bool, lal::linarr::__syntactic_dependency_tree_size>;

%include "lal/linarr/syntactic_dependency_tree/classify.hpp"

// -----------------------
// Add chunking algorithms

namespace lal {
namespace linarr {

	// ignore non-const
	%ignore chunk_sequence::get_chunk(std::size_t) noexcept;

} // -- namespace linarr
} // -- namespace lal


%include "lal/linarr/chunking/chunk.hpp"
%include "lal/linarr/chunking/chunking.hpp"

// -------------------------
// Extendind the C++ classes

namespace lal {
namespace linarr {

	%extend chunk {
		std::string __repr__() const {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
	}

	%extend chunk_sequence {
		std::string __repr__() const {
			std::ostringstream out;
			out << *$self;
			return out.str();
		}
	}

} // -- namespace linarr
} // -- namespace lal

// --------------------------------
// Extending the function templates

namespace lal {
namespace linarr {

	%template(__MDD_1level_rational_undirected_graph)	mean_dependency_distance_1level_rational<graphs::undirected_graph>;
	%template(__MDD_1level_rational_directed_graph)		mean_dependency_distance_1level_rational<graphs::directed_graph>;
	%template(__MDD_1level_rational_free_tree)			mean_dependency_distance_1level_rational<graphs::free_tree>;
	%template(__MDD_1level_rational_rooted_tree)		mean_dependency_distance_1level_rational<graphs::rooted_tree>;

	%template(__MDD_1level_undirected_graph)			mean_dependency_distance_1level<graphs::undirected_graph>;
	%template(__MDD_1level_directed_graph)				mean_dependency_distance_1level<graphs::directed_graph>;
	%template(__MDD_1level_free_tree)					mean_dependency_distance_1level<graphs::free_tree>;
	%template(__MDD_1level_rooted_tree)					mean_dependency_distance_1level<graphs::rooted_tree>;

	%template(__MDD_2level_rational_undirected_graph)	mean_dependency_distance_2level_rational<graphs::undirected_graph>;
	%template(__MDD_2level_rational_directed_graph)		mean_dependency_distance_2level_rational<graphs::directed_graph>;
	%template(__MDD_2level_rational_free_tree)			mean_dependency_distance_2level_rational<graphs::free_tree>;
	%template(__MDD_2level_rational_rooted_tree)		mean_dependency_distance_2level_rational<graphs::rooted_tree>;

	%template(__MDD_2level_undirected_graph)			mean_dependency_distance_2level<graphs::undirected_graph>;
	%template(__MDD_2level_directed_graph)				mean_dependency_distance_2level<graphs::directed_graph>;
	%template(__MDD_2level_free_tree)					mean_dependency_distance_2level<graphs::free_tree>;
	%template(__MDD_2level_rooted_tree)					mean_dependency_distance_2level<graphs::rooted_tree>;

	%template(__is_arrangement_undirected_graph)		is_arrangement<graphs::undirected_graph>;
	%template(__is_arrangement_directed_graph)			is_arrangement<graphs::directed_graph>;
	%template(__is_arrangement_free_tree)				is_arrangement<graphs::free_tree>;
	%template(__is_arrangement_rooted_tree)				is_arrangement<graphs::rooted_tree>;

	%template(__is_planar_undirected_graph)				is_planar<graphs::undirected_graph>;
	%template(__is_planar_directed_graph)				is_planar<graphs::directed_graph>;
	%template(__is_planar_free_tree)					is_planar<graphs::free_tree>;
	%template(__is_planar_rooted_tree)					is_planar<graphs::rooted_tree>;

	%template(__is_bipartite_undirected_graph)			is_bipartite<graphs::undirected_graph>;
	%template(__is_bipartite_directed_graph)			is_bipartite<graphs::directed_graph>;
	%template(__is_bipartite_free_tree)					is_bipartite<graphs::free_tree>;
	%template(__is_bipartite_rooted_tree)				is_bipartite<graphs::rooted_tree>;

} // -- namespace linarr
} // -- namespace lal



%pythoncode %{

def mean_dependency_distance_1level_rational(L, P):
	r"""
	1-level mean dependency distance of a list of graphs `L`.
	
	Given a list of graphs :math:`L` and a list of linear arrangements for each of them, :math:`\Pi`, computes the 1-level Mean Dependency Distance as the quotient of :math:`D`, the sum of all the edge lengths of each graph, and of :math:`M` the sum of the number of edges of all the graphs.

	Formally, given a list of linear arrangements :math:`\Pi = \{\pi_i\}_{i=1}^k` and a list of graphs :math:`L = \{L_i\}_{i=1}^k`, computes :math:`D/M`, where
	
	- :math:`D = \sum_{i=1}^k D(L_i, \pi_i)` is the sum of edge lengths of all graphs.
	- :math:`M = \sum_{i=1}^k |E(L_i)|` is the sum of the number of edges of all graphs.
	
	Parameters
	----------
	* `L` :
		List of input graphs.
	* `P` :
		List of linear arrangements of the nodes :math:`\Pi = \{\pi_i\}_{i=1}^k`. When omitted, :math:`\pi_I` is used for every graph.
	
	Returns
	-------
	Jing and Liu's 1-level :math:`MDD` for an ensemble of graphs as an exact rational value.
	"""
	
	__full_type = str(type(L[0]))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__MDD_1level_rational_" + __type_graph ](L, P)

def mean_dependency_distance_1level(L, P):
	r"""
	1-level mean dependency distance of a list of graphs `L`.
	
	Given a list of graphs :math:`L` and a list of linear arrangements for each of them, :math:`\Pi`, computes the 1-level Mean Dependency Distance as the quotient of :math:`D`, the sum of all the edge lengths of each graph, and of :math:`M` the sum of the number of edges of all the graphs.

	Formally, given a list of linear arrangements :math:`\Pi = \{\pi_i\}_{i=1}^k` and a list of graphs :math:`L = \{L_i\}_{i=1}^k`, computes :math:`D/M`, where
	
	- :math:`D = \sum_{i=1}^k D(L_i, \pi_i)` is the sum of edge lengths of all graphs.
	- :math:`M = \sum_{i=1}^k |E(L_i)|` is the sum of the number of edges of all graphs.
	
	Parameters
	----------
	* `L` :
		List of input graphs.
	* `P` :
		List of linear arrangements of the nodes :math:`\Pi = \{\pi_i\}_{i=1}^k`. When omitted, :math:`\pi_I` is used for every graph.
	
	Returns
	-------
	Jing and Liu's 1-level :math:`MDD` for an ensemble of graphs as a floating point value.
	"""
	
	__full_type = str(type(L[0]))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__MDD_1level_" + __type_graph ](L, P)

def mean_dependency_distance_2level_rational(L, P):
	r"""
	2-level Mean Dependency Distance :math:`MDD` over an ensemble of graphs.
	
	Given a list of graphs :math:`L` and a list of linear arrangements of the nodes for each of them, :math:`\Pi`, computes the 2-level Mean Dependency Distance, i.e., it computes the average Mean Dependency Distance of the graphs in the list.

	Formally, given a list of graphs :math:`L = \{L_i\}_{i=1}^k` and a list of linear arrangements :math:`\Pi = \{\pi_i\}_{i=1}^k`, computes :math:`(1/k)S_{<d>}`, where :math:`S_{<d>} = \sum_{i=1}^k MDD(L_i, \pi_i)` is the sum of the mean dependency distances of every graph (see ``mean_dependency_distance_rational`` for details on the definition of the Mean Dependency Distance).
	
	Parameters
	----------
	* `L` :
		List of input graphs.
	* `P` :
		List of linear arrangements of the nodes :math:`\Pi = \{\pi_i\}_{i=1}^k`. When omitted, :math:`\pi_I` is used for every graph.

	Returns
	-------
	Jing and Liu's 2-level :math:`MDD` for an ensemble of graphs as an exact rational value.
	"""
	
	__full_type = str(type(L[0]))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__MDD_2level_rational_" + __type_graph ](L, P)

def mean_dependency_distance_2level(L, P):
	r"""
	2-level Mean Dependency Distance :math:`MDD` over an ensemble of graphs.
	
	Given a list of graphs :math:`L` and a list of linear arrangements of the nodes for each of them, :math:`P`, computes the 2-level Mean Dependency Distance, i.e., it computes the average Mean Dependency Distance of the graphs in the list.

	Formally, given a list of graphs :math:`L = \{L_i\}_{i=1}^k` and a list of linear arrangements :math:`\Pi = \{\pi_i\}_{i=1}^k`, computes :math:`(1/k)S_{<d>}`, where :math:`S_{<d>} = \sum_{i=1}^k MDD(L_i, \pi_i)` is the sum of the mean dependency distances of every graph (see ``mean_dependency_distance_rational`` for details on the definition of the Mean Dependency Distance).
	
	Parameters
	----------
	* `L` :
		List of input graphs.
	* `P` :
		List of linear arrangements of the nodes :math:`P = \{\pi_i\}_{i=1}^k`. When omitted, :math:`\pi_I` is used for every graph.

	Returns
	-------
	Jing and Liu's 2-level :math:`MDD` for an ensemble of graphs as a floating point value.
	"""
	
	__full_type = str(type(L[0]))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__MDD_2level_" + __type_graph ](L, P)

def is_arrangement(g, arr):
	r"""
	Is a given arrangement valid?
	
	Checks that an input arrangement is valid for the corresponding input graph.
	An arrangement is valid if it is a valid permutation of the vertices of the
	graph.
	
	Parameters
	----------
	* `g` :
		Input graph.
	* `arr` :
		Input arrangement.

	Returns
	-------
	Whether or not the input arrangement is a valid permutation.
	"""
	
	__full_type = str(type(g))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__is_arrangement_" + __type_graph ](g,arr)

def is_planar(g, arr):
	r"""
	Is a given arrangement planar?
	
	A planar arrangement of a graph is an arrangement in which there are no
	edge crossings. If the input arrangement is empty then the identity
	arrangement \f$\pi_I\f$ is used.
	
	Parameters
	----------
	* `g` :
		Input graph.
	* `arr` :
		Input arrangement.

	Returns
	-------
	Whether or not the input graph arranged with the input arrangement is planar.
	"""
	
	__full_type = str(type(g))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % gtype)
		return None
	
	return globals()[ "__is_planar_" + __type_graph ](g,arr)

def is_bipartite_no_coloring(g, arr):
	r"""
	Is a given arrangement bipartite?
	
	A bipartite arrangement of a (bipartite) graph \f$G=(v_1\cup V_2, E)\$f
	is an arrangement in which the vertices of \f$V_1\f$ are arranged
	consecutively starting at the leftmost position, and then are arranged
	the vertices of \f$V_2\f$, or vice versa.
	
	Parameters
	----------
	* `g` :
		Input graph.
	* `arr` :
		Input arrangement.

	Returns
	-------
	Whether or not the input graph arranged with the input arrangement is bipartite.
	"""
	
	__full_type = str(type(g))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["undirected_graph", "directed_graph", "free_tree", "rooted_tree"]:
		print("Error: graph type '%s' is not valid" % __type_graph)
		return None
	
	return globals()[ "__is_bipartite_" + __type_graph ](g,arr)

%}

%pythoncode %{
__types = types
del types

# remove unnecessary modules (not required for python)
del graphs
del numeric
del tree_type # this comes from graphs
%}
