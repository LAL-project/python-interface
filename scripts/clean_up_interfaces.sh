#!/bin/bash

###########################################################################
#
# SWIG-generated python wrapper for the Linear Arrangement Library
# Copyright (C) 2021 - 2023 Lluís Alemany Puig
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# Contact:
#
#     Lluís Alemany Puig (lalemany@cs.upc.edu)
#         LARCA (Laboratory for Relational Algorithmics, Complexity and Learning)
#         CQL (Complexity and Quantitative Linguistics Lab)
#         Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
#         Webpage: https://cqllab.upc.edu/people/lalemany/
#
###########################################################################

f=$1

if [ ! -f "$f" ]; then
	echo -e "\e[1;1;31m! File\e[0m '$f' \e[1;1;31mdoes not exist\e[0m"
	exit
fi

echo -e "\e[1;1;35m* Remove C++ types\e[0m"

echo -e "\e[1;1;36m    - Remove return types from function definitions\e[0m"
sed -i 's/) -> \".*\":/):/g' $f

echo -e "\e[1;1;36m    - Remove parameter types from function definitions\e[0m"
sed -i 's/: \"bool\"//g' $f
sed -i 's/: \"uint32_t\"//g' $f
sed -i 's/: \"lal::node\"//g' $f
sed -i 's/: \"free_tree\"//g' $f
sed -i 's/: \"rooted_tree\"//g' $f
sed -i 's/: \"undirected_graph\"//g' $f
sed -i 's/: \"directed_graph\"//g' $f

sed -i 's/: \"lal.io.treebank_feature const &\"//g' $f

sed -i 's/: \"std::size_t const &\"//g' $f
sed -i 's/: \"std::size_t const\"//g' $f
sed -i 's/: \"std::size_t\"//g' $f
sed -i 's/: \"size_t const &\"//g' $f
sed -i 's/: \"size_t const\"//g' $f
sed -i 's/: \"size_t\"//g' $f

sed -i 's/: \"std::string const &\"//g' $f
sed -i 's/: \"std::string const\"//g' $f

sed -i 's/: \"std::vector< .* > const &\"//g' $f
sed -i 's/: \"std::vector< .* > const\"//g' $f
sed -i 's/: \"std::vector< .* > &\"//g' $f

sed -i 's/: \"std::vector< .* >::size_type const &\"//g' $f
sed -i 's/: \"std::vector< .* >::size_type const\"//g' $f
sed -i 's/: \"std::vector< .* >::size_type &\"//g' $f
sed -i 's/: \"std::vector< .* >::size_type\"//g' $f

sed -i 's/: \"std::vector< .* >::value_type const &\"//g' $f
sed -i 's/: \"std::vector< .* >::value_type const\"//g' $f
sed -i 's/: \"std::vector< .* >::value_type &\"//g' $f
sed -i 's/: \"std::vector< .* >::value_type\"//g' $f

sed -i 's/: \"std::vector< .* >::iterator const &\"//g' $f
sed -i 's/: \"std::vector< .* >::iterator const\"//g' $f
sed -i 's/: \"std::vector< .* >::iterator &\"//g' $f
sed -i 's/: \"std::vector< .* >::iterator\"//g' $f

sed -i 's/: \"std::vector< .* >::difference_type const &\"//g' $f
sed -i 's/: \"std::vector< .* >::difference_type const\"//g' $f
sed -i 's/: \"std::vector< .* >::difference_type &\"//g' $f
sed -i 's/: \"std::vector< .* >::difference_type\"//g' $f

# From '::' to '.' for a more Python-looking code.
# This can't be applied to the documentation.i because that would
# change the definitions of %feature definitions, like so
#
#	from
#
#		%feature("docstring") lal::generate::all_lab_rooted_trees 
#
#	to
#
#		%feature("docstring") lal.generate.all_lab_rooted_trees 
#

echo -e "\e[1;1;35m* Replace '::' with '.'\e[0m"
sed -i 's/::/./g' $f
