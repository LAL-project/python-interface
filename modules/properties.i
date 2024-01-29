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

%module properties

%import types.i
%import graphs.i
%import numeric.i

%include documentation.i

%{
#include <lal/graphs.hpp>
#include <lal/properties.hpp>
%}

%include "lal/properties/C_rla.hpp"
%include "lal/properties/D_rla.hpp"
%include "lal/properties/degrees.hpp"
%include "lal/properties/hierarchical_distance.hpp"
%include "lal/properties/maximum_spanning_trees.hpp"
%include "lal/properties/Q.hpp"
%include "lal/properties/tree_centre.hpp"
%include "lal/properties/tree_centroid.hpp"
%include "lal/properties/tree_diameter.hpp"

namespace lal {
namespace properties {

%ignore bipartite_graph_coloring::bipartite_graph_coloring(bipartite_graph_coloring&&) noexcept;
%ignore bipartite_graph_coloring::operator= (const bipartite_graph_coloring&) noexcept;
%ignore bipartite_graph_coloring::operator= (bipartite_graph_coloring&&) noexcept;
%ignore bipartite_graph_coloring::operator[] noexcept;
%ignore bipartite_graph_coloring::operator[] noexcept;
%ignore bipartite_graph_coloring::get_color_of(node) noexcept;

} // -- namespace properties
} // -- namespace lal

%include "lal/properties/bipartite_graph_coloring.hpp"
%include "lal/properties/bipartite_graph_colorability.hpp"

%include "lal/properties/branchless_path.hpp"
// Instantiate the (only) templated function of 'branchless_path'
%template(__is_antenna_free_tree) lal::properties::branchless_path::is_antenna<lal::graphs::free_tree>;
%template(__is_antenna_rooted_tree) lal::properties::branchless_path::is_antenna<lal::graphs::rooted_tree>;

%pythoncode %{
__types = types
del types

def is_antenna(self, t):
	r"""
	Is the given path an antenna?
	
	A branchless path is an antenna if any of its two endpoints is a degree-1 vertex.
	
	Parameters
	----------
	* `t` :
		Input tree.
	
	Returns
	-------
	Whether or not the input graph arranged with the input arrangement is bipartite.
	"""
	
	__full_type = str(type(t))
	__pos_graph = __full_type.find("graphs.")
	__type_graph = __full_type[__pos_graph + len("graphs."):-2]
	
	if __type_graph not in ["free_tree", "rooted_tree"]:
		print("Error: tree type '%s' is not valid" % __type_graph)
		return None
	
	if __type_graph == "free_tree":
		return self._branchless_path__is_antenna_free_tree(t)
	return self._branchless_path__is_antenna_rooted_tree(t)

setattr(branchless_path, is_antenna.__name__, is_antenna)

del is_antenna

# remove unnecessary modules
del graphs
del numeric
del tree_type
%}
