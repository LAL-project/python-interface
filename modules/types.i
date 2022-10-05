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

%module types

%include documentation.i

%{
// C++ includes
#include <iostream>
#include <sstream>

// lal includes
#include <lal/basic_types.hpp>
#include <lal/linear_arrangement.hpp>
%}

// --------------
// C++ interfaces

%include stdint.i
%include std_vector.i
%include std_string.i
%include std_pair.i

// -------------------------
// renaming of C++ templates
// (C++ types)

%template(_list_uint32) std::vector<uint32_t>;
%template(_list_uint64) std::vector<uint64_t>;
%template(_list_bool) std::vector<bool>;
%template(_list_string) std::vector<std::string>;

// ----------------
// ignore operators

namespace lal {

%ignore node_t::operator++ () noexcept;
%ignore node_t::operator-- () noexcept;
%ignore node_t::operator=;

%ignore position_t::operator++ () noexcept;
%ignore position_t::operator-- () noexcept;
%ignore position_t::operator=;

%ignore linear_arrangement::linear_arrangement(linear_arrangement&&) noexcept;
%ignore linear_arrangement::operator= (const linear_arrangement&) noexcept;
%ignore linear_arrangement::operator= (linear_arrangement&&) noexcept;
%ignore linear_arrangement::operator= (const std::vector<position>&) noexcept;
%ignore linear_arrangement::operator[];
%ignore linear_arrangement::operator[];
%ignore linear_arrangement::begin_direct() noexcept;
%ignore linear_arrangement::end_direct() noexcept;
%ignore linear_arrangement::begin_inverse() noexcept;
%ignore linear_arrangement::end_inverse() noexcept;

} // -- namespace lal

%include "lal/basic_types.hpp"

// -------------------------
// renaming of C++ templates
// (lal types)

%template(_edge) std::pair<lal::node, lal::node>;
%template(_edge_pair) std::pair<lal::edge, lal::edge>;

%template(_list_edge) std::vector<lal::edge>;
%template(_list_edge_pair) std::vector<lal::edge_pair>;

namespace lal {

%template(node_t) node_t::node_t<uint64_t, std::enable_if_t<true, bool> = true>;
%template(position_t) position_t::position_t<uint64_t, std::enable_if_t<true, bool> = true>;

} // -- namespace lal

%include "lal/linear_arrangement.hpp"

namespace lal {

%template(assign) linear_arrangement::assign<node, position, std::enable_if_t<true, bool> = true>;

%template(_swap_nodes) linear_arrangement::swap<node_t, std::enable_if_t<true, bool> = true>;
%template(_swap_positions) linear_arrangement::swap<position_t, std::enable_if_t<true, bool> = true>;

} // -- namespace lal

namespace lal {

%extend linear_arrangement {

	std::string __repr__() const {
		std::ostringstream out;
		out << "(";
		const std::size_t size = $self->size();
		if (size > 0) {
			out << (*$self)[lal::node_t{0}];
			for (lal::node_t u = 1; u < size; ++u) {
				out << ", " << (*$self)[u];
			}
		}
		out << ") | (";
		if (size > 0) {
			out << (*$self)[lal::position_t{0}];
			for (lal::position_t p = 1; p < size; ++p) {
				out << ", " << (*$self)[p];
			}
		}
		out << ")";
		return out.str();
	}

}

} // -- namespace lal

%pythoncode %{

def swap_nodes(self, u,v):
	r"""
	Swaps the two nodes passed as parameters.
	
	Parameters
	----------
	* `u` :  
		Pne of the nodes
	* `v` :  
		The other node
	"""
	u_t = node_t(u)
	v_t = node_t(v)
	self._swap_nodes(u_t, v_t)

def swap_positions(self, pu,pv):
	r"""
	Swaps the two nodes at the positions passed as parameters.
	
	Parameters
	----------
	* `pu` :  
		The position of one of the nodes
	* `pv` :  
		The position of one of the other node
	"""
	pu_t = position_t(pu)
	pv_t = position_t(pv)
	self._swap_positions(pu_t, pv_t)

setattr(linear_arrangement, swap_nodes.__name__, swap_nodes)
setattr(linear_arrangement, swap_positions.__name__, swap_positions)

del swap_nodes
del swap_positions

del linear_arrangement_from_direct
del linear_arrangement_from_inverse
%}
