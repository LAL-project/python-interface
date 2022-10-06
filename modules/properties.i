/**************************************************************************
 *
 *   SWIG-generated python wrapper for the Linear Arrangement Library
 *   Copyright (C) 2021-2022 Lluís Alemany Puig
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 *   Contact:
 *
 *      Lluís Alemany Puig (lalemany@cs.upc.edu)
 *          LARCA (Laboratory for Relational Algorithmics, Complexity and Learning)
 *          CQL (Complexity and Quantitative Linguistics Lab)
 *          Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
 *          Webpage: https://cqllab.upc.edu/people/lalemany/
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

%pythoncode %{
__types = types
del types

# remove unnecessary modules
del graphs
del numeric
del tree_type
%}
