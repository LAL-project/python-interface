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

%module properties

%include std_vector.i
%include std_pair.i

%include documentation.i

%import types.i
%import graphs.i
%import numeric.i

%{
// lal includes
#include <lal/graphs.hpp>
#include <lal/properties.hpp>

// custom includes
#include "auxiliary_classes/generic_iterator.hpp"
#include "auxiliary_classes/properties/connected_components_iterator.hpp"
%}

%include "auxiliary_classes/generic_iterator.hpp"

%exception {
	try {
		$action
	}
	catch (StopIteration) {
		PyErr_SetString(PyExc_StopIteration, "End of iterator");
		return nullptr;
	}
}

%template (_vector_vector_node) std::vector<std::vector<lal::node> >;

%include "lal/properties/C_rla.hpp"
%include "lal/properties/D_rla.hpp"

%include "lal/properties/degrees.hpp"
%include "lal/properties/hierarchical_distance.hpp"
%include "lal/properties/maximum_spanning_trees.hpp"
%include "lal/properties/Q.hpp"
%include "lal/properties/tree_centre.hpp"
%include "lal/properties/tree_centroid.hpp"
%include "lal/properties/tree_diameter.hpp"
%include "lal/properties/vertex_orbits.hpp"

namespace lal {
namespace properties {

	%ignore bipartite_graph_coloring::bipartite_graph_coloring(bipartite_graph_coloring&&) noexcept;
	%ignore bipartite_graph_coloring::operator= (const bipartite_graph_coloring&) noexcept;
	%ignore bipartite_graph_coloring::operator= (bipartite_graph_coloring&&) noexcept;
	%ignore bipartite_graph_coloring::operator[] noexcept;
	%ignore bipartite_graph_coloring::operator[] noexcept;
	%ignore bipartite_graph_coloring::get_color_of(node) noexcept;
	
	%extend bipartite_graph_coloring {
		uint64_t __getitem__(unsigned int i) const noexcept {
			return (*($self))[i];
		}
	}

} // -- namespace properties
} // -- namespace lal

%include "lal/properties/bipartite_graph_coloring.hpp"
%include "lal/properties/bipartite_graph_colorability.hpp"

namespace lal {
namespace properties {
	
	%ignore branchless_path::operator[];
	
} // -- namespace properties
} // -- namespace lal

%include "lal/properties/branchless_path.hpp"

namespace lal {
namespace properties {

	// Instantiate the (only) templated function of 'branchless_path'.
	// This function is added to the classes at the end of the file.
	%template (__is_antenna_free_tree) branchless_path::is_antenna<graphs::free_tree>;
	%template (__is_antenna_rooted_tree) branchless_path::is_antenna<graphs::rooted_tree>;

} // -- namespace properties
} // -- namespace lal

%include "lal/properties/branchless_paths_compute.hpp"

namespace lal {
namespace properties {
	
	%ignore connected_components::operator[];
	%ignore connected_components::add_graph;
	%ignore connected_components::begin;
	%ignore connected_components::end;
	
} // -- namespace properties
} // -- namespace lal

%include "lal/properties/connected_components.hpp"

%template (connected_components_directed_graph) 
	lal::properties::connected_components<lal::graphs::directed_graph>;
%template (connected_components_undirected_graph)
	lal::properties::connected_components<lal::graphs::undirected_graph>;

%template (_connected_components_dg_iterator) 
	generic_iterator<
		lal::properties::connected_components<lal::graphs::directed_graph>,
		lal::graphs::directed_graph
	>;
%template (_connected_components_ug_iterator) 
	generic_iterator<
		lal::properties::connected_components<lal::graphs::undirected_graph>,
		lal::graphs::undirected_graph
	>;
%include "auxiliary_classes/properties/connected_components_iterator.hpp"

%template (connected_components_dg_iterator)
	connected_components_iterator<lal::graphs::directed_graph>;
%template (connected_components_ug_iterator)
	connected_components_iterator<lal::graphs::undirected_graph>;

namespace lal {
namespace properties {
	
	%extend connected_components<graphs::undirected_graph> {
		const graphs::undirected_graph& __getitem__(unsigned int i) const noexcept {
			return (*($self))[i];
		}
		
		connected_components_ug_iterator __iter__() noexcept {
			return connected_components_ug_iterator($self->begin(), $self->end());
		}
	}
	
	%extend connected_components<graphs::directed_graph> {
		const graphs::directed_graph& __getitem__(unsigned int i) const noexcept {
			return (*($self))[i];
		}
		
		connected_components_dg_iterator __iter__() noexcept {
			return connected_components_dg_iterator($self->begin(), $self->end());
		}
	}

} // -- namespace properties
} // -- namespace lal

%include "lal/properties/connected_components_compute.hpp"

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
