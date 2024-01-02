/**************************************************************************
 *
 *   SWIG-generated python wrapper for the Linear Arrangement Library
 *   Copyright (C) 2021-2024 Lluís Alemany Puig
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
 *          LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
 *          CQL (Complexity and Quantitative Linguistics Lab)
 *          Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
 *          Webpage: https://cqllab.upc.edu/people/lalemany/
 *
 *************************************************************************/

%module algorithms_Dmin_projective

%{
#include <lal/linarr/D/algorithms_Dmin_projective.hpp>
%}
%include "lal/linarr/D/algorithms_Dmin_projective.hpp"

%pythoncode %{
__mod_name = "algorithms_Dmin_projective"
__to_replace = "algorithms_Dmin_projective_"
%}

%include rename_enum_contents.i
