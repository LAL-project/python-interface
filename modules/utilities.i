/**************************************************************************
 *
 * SWIG-generated python wrapper for the Linear Arrangement Library
 * Copyright (C) 2021 - 2026 Lluís Alemany Puig
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

%module utilities

%include documentation.i

%import graphs.i

%{
// C++ includes
#include <sstream>

// lal includes
#include <lal/graphs.hpp>
#include <lal/utilities.hpp>
%}

%include "lal/utilities/tree_isomorphism.hpp"
%include "lal/utilities/decorator.hpp"

%template (decorated_ugraph) lal::utilities::decorator<lal::graphs::undirected_graph>;
%template (decorated_dgraph) lal::utilities::decorator<lal::graphs::directed_graph>;
%template (decorated_ftree) lal::utilities::decorator<lal::graphs::free_tree>;
%template (decorated_rtree) lal::utilities::decorator<lal::graphs::rooted_tree>;

namespace lal {
namespace utilities {

%extend decorator<lal::graphs::undirected_graph> {
	decorator<lal::graphs::undirected_graph> __radd__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::undirected_graph> d;
		d.prefix = s;
		d.value = std::move($self->value);
		d.suffix = std::move($self->prefix);
		return d;
	}
	decorator<lal::graphs::undirected_graph> __add__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::undirected_graph> d;
		d.prefix = std::move($self->prefix);
		d.value = std::move($self->value);
		d.suffix = s;
		return d;
	}
	std::string __repr__() {
		std::ostringstream oss;
		oss << *$self;
		return oss.str();
	}
}

%extend decorator<lal::graphs::directed_graph> {
	decorator<lal::graphs::directed_graph> __radd__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::directed_graph> d;
		d.prefix = s;
		d.value = std::move($self->value);
		d.suffix = std::move($self->prefix);
		return d;
	}
	decorator<lal::graphs::directed_graph> __add__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::directed_graph> d;
		d.prefix = std::move($self->prefix);
		d.value = std::move($self->value);
		d.suffix = s;
		return d;
	}
	std::string __repr__() {
		std::ostringstream oss;
		oss << *$self;
		return oss.str();
	}
}

%extend decorator<lal::graphs::free_tree> {
	decorator<lal::graphs::free_tree> __radd__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::free_tree> d;
		d.prefix = s;
		d.value = std::move($self->value);
		d.suffix = std::move($self->prefix);
		return d;
	}
	decorator<lal::graphs::free_tree> __add__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::free_tree> d;
		d.prefix = std::move($self->prefix);
		d.value = std::move($self->value);
		d.suffix = s;
		return d;
	}
	std::string __repr__() {
		std::ostringstream oss;
		oss << *$self;
		return oss.str();
	}
}

%extend decorator<lal::graphs::rooted_tree> {
	decorator<lal::graphs::rooted_tree> __radd__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::rooted_tree> d;
		d.prefix = s;
		d.value = std::move($self->value);
		d.suffix = std::move($self->prefix);
		return d;
	}
	decorator<lal::graphs::rooted_tree> __add__(const std::string& s) {
		lal::utilities::decorator<lal::graphs::rooted_tree> d;
		d.prefix = std::move($self->prefix);
		d.value = std::move($self->value);
		d.suffix = s;
		return d;
	}
	std::string __repr__() {
		std::ostringstream oss;
		oss << *$self;
		return oss.str();
	}
}

} // namespace utilities
} // namespace lal

%pythoncode %{
__types = types
del types

# remove unnecessary modules
del graphs
del tree_type
%}
