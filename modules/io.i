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

%module io

%include std_string.i
%include std_vector.i

%import types.i
%import graphs.i
%import enums/head_vector_error_type.i
%import enums/treebank_file_error_type.i
%import enums/treebank_feature.i

%include documentation.i

%{

// C++ includes
#include <optional>
#include <sstream>
#include <tuple>

// lal includes
#include <lal/graphs.hpp>
#include <lal/io.hpp>

template<class T>
struct _optional {
	std::optional<T> m_opt;
	inline bool has_contents() const noexcept { return (m_opt ? true : false); }
	inline T contents() const noexcept { return *m_opt; }
};

template<class T> _optional<T> read_edge_list
(const std::string& filename, bool norm = true, bool check = true) {
	_optional<T> r;
	r.m_opt = lal::io::read_edge_list<T>(filename, norm, check);
	return r;
}

template<class T> _optional<T> read_head_vector
(const std::string& filename, bool norm = true, bool check = true) {
	_optional<T> r;
	r.m_opt = lal::io::read_head_vector<T>(filename, norm, check);
	return r;
}

%}

/* ---------- WRAP _optional ------------- */

template<class T>
struct _optional {
	std::optional<T> m_opt;
	bool has_contents() const noexcept { return (m_opt ? true : false); }
	T contents() const noexcept { return *m_opt; }
};

// ---------- INSTANTIATE _optional

%template(_optional_directed_graph) _optional<lal::graphs::directed_graph>;
%template(_optional_undirected_graph) _optional<lal::graphs::undirected_graph>;
%template(_optional_free_tree) _optional<lal::graphs::free_tree>;
%template(_optional_rooted_tree) _optional<lal::graphs::rooted_tree>;

/* ---------- WRAP read_edge_list ------------- */

template<class T> _optional<T> read_edge_list
(const std::string& filename, bool norm = true, bool check = true);

// ---------- INSTANTIATE read_edge_list

%template(read_edge_list_directed_graph) read_edge_list<lal::graphs::directed_graph>;
%template(read_edge_list_undirected_graph) read_edge_list<lal::graphs::undirected_graph>;
%template(read_edge_list_free_tree) read_edge_list<lal::graphs::free_tree>;
%template(read_edge_list_rooted_tree) read_edge_list<lal::graphs::rooted_tree>;

/* ---------- CALL read_edge_list ------------- */

%pythoncode %{

def read_edge_list(gtype, filename, norm = True, check = True):
	r"""
	Reads a graph in edge list format. This format consists of a list of
	all the graph's edges. Each edge is described as a pair of indices of
	the nodes at each end of the edge. Nodes are labelled with indices
	starting at 0. The resulting number of nodes of the graph will be the
	maximum index in the file plus 1.
	
	Parameters
	----------
	* `gtype` :
		A string that encodes the type of graph. Must be one of:
		
		- free_tree
		- rooted_tree
		- undirected_graph
		- directed_graph
	
	* `filename` :
		The name of the file from which the list of edges is to be read.
	
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
	
	opt = globals()[ "read_edge_list_" + gtype ](filename, norm, check)
	if opt.has_contents(): return opt.contents()
	return None
%}

/* ---------- WRAP read_head_vector ------------- */

template<class T> _optional<T> read_head_vector
(const std::string& filename, bool norm = true, bool check = true);

// ---------- INSTANTIATE read_head_vector

%template(read_head_vector_free_tree) read_head_vector<lal::graphs::free_tree>;
%template(read_head_vector_rooted_tree) read_head_vector<lal::graphs::rooted_tree>;

/* ---------- CALL read_edge_list ------------- */

%pythoncode %{

def read_head_vector(gtype, filename, norm = True, check = True):
	r"""
	A head vector of an @e n-vertex tree is a list of non-negative integer numbers. The number at position @e i denotes the parent node of the vertex at said position. Value '0' denotes the root. In this case, the vertex corresponding to the value '0' is not labelled as a root.
	
	Each tree is formatted as a list of whole, positive numbers (including zero), each representing a node of the tree. The number 0 denotes the root of the tree, and a number at a certain position indicates its parent node. For example, when number 4 is at position 9 it means that node 9 has parent node 4. Therefore, if number 0 is at position 1 it means that node 1 is the root of the tree. A complete example of such a tree's representation is the following

		0 3 4 1 6 3

	which should be interpreted as

		(a) predecessor:       0 3 4 1 6 3
		(b) node of the tree:  1 2 3 4 5 6

	Note that lines like these are not valid:

		(1) 0 2 2 2 2 2
		(2) 2 0 0

	Line (1) is not valid due to a self-reference in the second position, and (2) not being valid due to containing two '0' (i.e., two roots).
	
	Parameters
	----------
	* `gtype` :
		A string that encodes the type of graph. Must be one of:
		- free_tree
		- rooted_tree
		- undirected_graph
		- directed_graph
	
	* `filename` :
		The name of the file from which the list of edges is to be read.
	
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
	
	opt = globals()[ "read_head_vector_" + gtype ](filename, norm, check)
	if opt.has_contents(): return opt.contents()
	return None
%}

/* ------- WRAP the correctness functions that return error messages -------- */

namespace lal {
namespace io {

%ignore head_vector_error::head_vector_error(head_vector_error&&) noexcept;
%ignore head_vector_error::operator= (const head_vector_error&) noexcept;
%ignore head_vector_error::operator= (head_vector_error&&) noexcept;

} // -- namespace io
} // -- namespace lal

%include "lal/io/head_vector_error.hpp"

namespace lal {
namespace io {

%extend head_vector_error {

	std::string __repr__() const noexcept {
		std::ostringstream out;
		out << $self->get_error_message();
		return out.str();
	}

}

} // -- namespace io
} // -- namespace lal

%template(_list__head_vector_error) std::vector<lal::io::head_vector_error>;
%template(_pair__uint64__head_vector_error) std::pair<uint64_t,lal::io::head_vector_error>;
%template(_list__uint64__head_vector_error) std::vector<std::pair<uint64_t,lal::io::head_vector_error>>;

namespace lal {
namespace io {

%ignore treebank_file_error::treebank_file_error(treebank_file_error&&) noexcept;
%ignore treebank_file_error::operator= (const treebank_file_error&) noexcept;
%ignore treebank_file_error::operator= (treebank_file_error&&) noexcept;

} // -- namespace io
} // -- namespace lal

%include "lal/io/treebank_file_error.hpp"

namespace lal {
namespace io {

%extend treebank_file_error {

	std::string __repr__() const noexcept {
		std::ostringstream out;
		out << $self->get_error_message();
		return out.str();
	}

}

} // -- namespace io
} // -- namespace lal

namespace lal {
namespace io {

%ignore treebank_file_report::treebank_file_report(treebank_file_report&&) noexcept;
%ignore treebank_file_report::treebank_file_report(treebank_file_error&&) noexcept;
%ignore treebank_file_report::treebank_file_report(uint64_t, head_vector_error&&) noexcept;
%ignore treebank_file_report::operator= (const treebank_file_report&) noexcept;
%ignore treebank_file_report::operator= (treebank_file_report&&) noexcept;
%ignore treebank_file_report::add_error(uint64_t, head_vector_error&&) noexcept;
%ignore treebank_file_report::set_treebank_error(treebank_file_error&&) noexcept;

%ignore treebank_collection_report::treebank_collection_report(treebank_collection_report&&) noexcept;
%ignore treebank_collection_report::treebank_collection_report(treebank_file_error&&) noexcept;
%ignore treebank_collection_report::operator= (const treebank_collection_report&) noexcept;
%ignore treebank_collection_report::operator= (treebank_collection_report&&) noexcept;
%ignore treebank_collection_report::add_report(uint64_t, treebank_file_report&&) noexcept;
%ignore treebank_collection_report::set_treebank_error(treebank_file_error&&) noexcept;

} // -- namespace io
} // -- namespace lal

%include "lal/io/treebank_file_report.hpp"

%include "lal/io/treebank_collection_report.hpp"
%template(_list__report_location) std::vector<lal::io::report_location>;

%include "lal/io/check_correctness.hpp"

/* -------------------------------------------------------------------------- */

namespace lal {
namespace io {

%ignore treebank_file_error::treebank_file_error(const treebank_file_error&) noexcept;
%ignore treebank_file_error::treebank_file_error(treebank_file_error&&) noexcept;
%ignore treebank_file_error::operator= (const treebank_file_error&) noexcept;
%ignore treebank_file_error::operator= (treebank_file_error&&) noexcept;

} // -- namespace io
} // -- namespace lal

%include "lal/io/treebank_file_error.hpp"

%include "lal/io/treebank_processor_base.hpp"

%include "lal/io/treebank_reader.hpp"
%include "lal/io/treebank_collection_reader.hpp"

%include "lal/io/treebank_processor.hpp"
%include "lal/io/treebank_collection_processor.hpp"

/* -------------------------------------------------------------------------- */

%pythoncode %{
__types = types
del types

# remove unnecessary modules
del graphs
del tree_type
%}
