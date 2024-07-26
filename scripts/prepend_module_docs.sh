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
#     Lluís Alemany Puig (lluis.alemany.puig@upc.edu)
#         LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
#         CQL (Complexity and Quantitative Linguistics Lab)
#         Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
#         Webpage: https://cqllab.upc.edu/people/lalemany/
#
###########################################################################

function prepend() {
	doc=$1
	file=$2
	
	mv $file $file.tmp
	cat $doc $file.tmp > $file
	rm -f $file.tmp
}

f=$1

if [ ! -f "$f" ]; then
	echo -e "\e[1;1;31m! File\e[0m '$f' \e[1;1;31mdoes not exist\e[0m"
	exit
fi

echo $f

line=$(head -n 1 $f)
if [ "$line" != "r\"\"\"" ]; then
	
	if [[ $f == *"generate"* ]]; then
		prepend modules_pydocs/generate.py $f
		
	elif [[ $f == *"graphs"* ]]; then
		prepend modules_pydocs/graphs.py $f

	elif [[ $f == *"version"* ]]; then
		prepend modules_pydocs/version.py $f

	elif [[ $f == *"io"* ]]; then
		prepend modules_pydocs/io.py $f

	elif [[ $f == *"iterators"* ]]; then
		prepend modules_pydocs/iterators.py $f

	elif [[ $f == *"linarr"* ]]; then
		prepend modules_pydocs/linarr.py $f

	elif [[ $f == *"numeric"* ]]; then
		prepend modules_pydocs/numeric.py $f

	elif [[ $f == *"properties"* ]]; then
		prepend modules_pydocs/properties.py $f

	elif [[ $f == *"utilities"* ]]; then
		prepend modules_pydocs/utilities.py $f

	elif [ "$f" == "lal.py" ] || [ "$f" == "laldebug.py" ]; then
		prepend modules_pydocs/lal.py $f
	
	elif [[ "$f" == *"algorithms_C"* ]]; then
		prepend modules_pydocs/algorithms_C.py $f
	
	elif [[ "$f" == *"algorithms_chunking"* ]]; then
		prepend modules_pydocs/algorithms_chunking.py $f
	
	elif [[ "$f" == *"algorithms_Dmin_projective"* ]]; then
		prepend modules_pydocs/algorithms_Dmin_projective.py $f
	
	elif [[ "$f" == *"algorithms_Dmin_planar"* ]]; then
		prepend modules_pydocs/algorithms_Dmin_planar.py $f
	
	elif [[ "$f" == *"algorithms_Dmin"* ]]; then
		prepend modules_pydocs/algorithms_Dmin.py $f
	
	elif [[ "$f" == *"tree_type"* ]]; then
		prepend modules_pydocs/tree_type.py $f
	
	elif [[ "$f" == *"treebank_feature_type"* ]]; then
		prepend modules_pydocs/treebank_feature_type.py $f
	
	elif [[ "$f" == *"treebank_file_error_type"* ]]; then
		prepend modules_pydocs/treebank_file_error_type.py $f
	
	elif [[ "$f" == *"head_vector_error_type"* ]]; then
		prepend modules_pydocs/head_vector_error_type.py $f
	
	elif [[ "$f" == *"syntactic_dependency_tree_type"* ]]; then
		prepend modules_pydocs/syntactic_dependency_tree_type.py $f
	
	elif [[ "$f" == *"types"* ]]; then
		prepend modules_pydocs/types.py $f
	
	else
		echo -e "\e[1;1;31m! Unhandled file '$f'\e[0m"
	fi
fi
