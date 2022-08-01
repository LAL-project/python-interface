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

%module generate

%include documentation.i

%import types.i
%import graphs.i

%{
#include <lal/generate.hpp>
%}

%include stdint.i

// ignore operators and constructors

namespace lal {
namespace generate {

// TREE GENERATING CLASSES

// BASE CLASS

%ignore _tree_generator::operator= (const _tree_generator&) noexcept;
%ignore _tree_generator::operator= (_tree_generator&&) noexcept;

// -- EXHAUSTIVE

%ignore all_lab_free_trees::all_lab_free_trees(all_lab_free_trees&&) noexcept;
%ignore all_lab_free_trees::operator= (const all_lab_free_trees&) noexcept;
%ignore all_lab_free_trees::operator= (all_lab_free_trees&&) noexcept;

%ignore all_ulab_free_trees::all_ulab_free_trees(all_ulab_free_trees&&) noexcept;
%ignore all_ulab_free_trees::operator= (const all_ulab_free_trees&) noexcept;
%ignore all_ulab_free_trees::operator= (all_ulab_free_trees&&) noexcept;

%ignore all_lab_rooted_trees::all_lab_rooted_trees(all_lab_rooted_trees&&) noexcept;
%ignore all_lab_rooted_trees::operator= (const all_lab_rooted_trees&) noexcept;
%ignore all_lab_rooted_trees::operator= (all_lab_rooted_trees&&) noexcept;

%ignore all_ulab_rooted_trees::all_ulab_rooted_trees(all_ulab_rooted_trees&&) noexcept;
%ignore all_ulab_rooted_trees::operator= (const all_ulab_rooted_trees&) noexcept;
%ignore all_ulab_rooted_trees::operator= (all_ulab_rooted_trees&&) noexcept;

// -- RANDOM

%ignore _rand_lab_free_trees::_rand_lab_free_trees(_rand_lab_free_trees&&) noexcept;
%ignore rand_lab_free_trees::rand_lab_free_trees(const rand_lab_free_trees&) noexcept;
%ignore rand_lab_free_trees::rand_lab_free_trees(rand_lab_free_trees&&) noexcept;
%ignore _rand_lab_free_trees::operator= (const _rand_lab_free_trees&) noexcept;
%ignore _rand_lab_free_trees::operator= (_rand_lab_free_trees&&) noexcept;
%ignore rand_lab_free_trees::operator= (const rand_lab_free_trees&) noexcept;
%ignore rand_lab_free_trees::operator= (rand_lab_free_trees&&) noexcept;

%ignore _rand_ulab_free_trees::_rand_ulab_free_trees(_rand_ulab_free_trees&&) noexcept;
%ignore rand_ulab_free_trees::rand_ulab_free_trees(const rand_ulab_free_trees&) noexcept;
%ignore rand_ulab_free_trees::rand_ulab_free_trees(rand_ulab_free_trees&&) noexcept;
%ignore _rand_ulab_free_trees::operator= (const _rand_ulab_free_trees&) noexcept;
%ignore _rand_ulab_free_trees::operator= (_rand_ulab_free_trees&&) noexcept;
%ignore rand_ulab_free_trees::operator= (const rand_ulab_free_trees&) noexcept;
%ignore rand_ulab_free_trees::operator= (rand_ulab_free_trees&&) noexcept;

%ignore _rand_lab_rooted_trees::_rand_lab_rooted_trees(_rand_lab_rooted_trees&&) noexcept;
%ignore rand_lab_rooted_trees::rand_lab_rooted_trees(const rand_lab_rooted_trees&) noexcept;
%ignore rand_lab_rooted_trees::rand_lab_rooted_trees(rand_lab_rooted_trees&&) noexcept;
%ignore _rand_lab_rooted_trees::operator= (const _rand_lab_rooted_trees&) noexcept;
%ignore _rand_lab_rooted_trees::operator= (_rand_lab_rooted_trees&&) noexcept;
%ignore rand_lab_rooted_trees::operator= (const rand_lab_rooted_trees&) noexcept;
%ignore rand_lab_rooted_trees::operator= (rand_lab_rooted_trees&&) noexcept;

%ignore _rand_ulab_rooted_trees::_rand_ulab_rooted_trees(_rand_ulab_rooted_trees&&) noexcept;
%ignore rand_ulab_rooted_trees::rand_ulab_rooted_trees(const rand_ulab_rooted_trees&) noexcept;
%ignore rand_ulab_rooted_trees::rand_ulab_rooted_trees(rand_ulab_rooted_trees&&) noexcept;
%ignore _rand_ulab_rooted_trees::operator= (const _rand_ulab_rooted_trees&) noexcept;
%ignore _rand_ulab_rooted_trees::operator= (_rand_ulab_rooted_trees&&) noexcept;
%ignore rand_ulab_rooted_trees::operator= (const rand_ulab_rooted_trees&) noexcept;
%ignore rand_ulab_rooted_trees::operator= (rand_ulab_rooted_trees&&) noexcept;

// ARRANGEMENT GENERATING CLASSES

// -- EXHAUSTIVE

%ignore all_planar_arrangements::all_planar_arrangements(all_planar_arrangements&&) noexcept;

%ignore all_projective_arrangements::all_projective_arrangements(all_projective_arrangements&&) noexcept;

// -- RANDOM

%ignore rand_planar_arrangements::rand_planar_arrangements(rand_planar_arrangements&&) noexcept;

%ignore rand_projective_arrangements::rand_projective_arrangements(rand_projective_arrangements&&) noexcept;

} // -- namespace generate
} // -- namespace lal

// This is a base class of all tree generators. It must be put before
// all other classes.
%include "lal/generate/tree_generator.hpp"
%template(free_tree_gen) lal::generate::_tree_generator<lal::graphs::free_tree>;
%template(rooted_tree_gen) lal::generate::_tree_generator<lal::graphs::rooted_tree>;

%include "lal/generate/all_lab_free_trees.hpp"
%include "lal/generate/all_lab_rooted_trees.hpp"
%include "lal/generate/all_ulab_free_trees.hpp"
%include "lal/generate/all_ulab_rooted_trees.hpp"

// This is a base class! It needs to be put before 'rand_lab_free_trees'.
%include "lal/generate/rand_ulab_rooted_trees.hpp"

%include "lal/generate/rand_lab_free_trees.hpp"
%include "lal/generate/rand_lab_rooted_trees.hpp"
%include "lal/generate/rand_ulab_free_trees.hpp"

%include "lal/generate/all_arrangements.hpp"
%include "lal/generate/all_planar_arrangements.hpp"
%include "lal/generate/all_projective_arrangements.hpp"
%include "lal/generate/rand_arrangements.hpp"
%include "lal/generate/rand_planar_arrangements.hpp"
%include "lal/generate/rand_projective_arrangements.hpp"

namespace lal {
namespace generate {

%extend rand_ulab_rooted_trees {

	graphs::rooted_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend rand_lab_rooted_trees {

	graphs::rooted_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend rand_ulab_free_trees {

	graphs::free_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend rand_lab_free_trees {

	graphs::free_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend all_ulab_rooted_trees {

	graphs::rooted_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend all_lab_rooted_trees {

	graphs::rooted_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend all_ulab_free_trees {

	graphs::free_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

%extend all_lab_free_trees {

	graphs::free_tree get_tree() noexcept {
		return $self->get_tree();
	}

}

} // -- namespace generate
} // -- namespace lal

%pythoncode %{
__types = types
del types

# remove unnecessary modules
del graphs
del tree_type
%}
