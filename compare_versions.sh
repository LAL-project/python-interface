#!/bin/bash

###########################################################################
#
#    SWIG-generated python wrapper for the Linear Arrangement Library
#    Copyright (C) 2021-2023 LAL-project developers
#         Lluís Alemany Puig
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
#    Contact:
#
#       Lluís Alemany Puig (lalemany@cs.upc.edu)
#           LARCA (Laboratory for Relational Algorithmics, Complexity and Learning)
#           CQL (Complexity and Quantitative Linguistics Lab)
#           Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
#           Webpage: https://cqllab.upc.edu/people/lalemany/
#
###########################################################################

# ------------------------------
# Usage:
#    ./compare_versions.sh what v1 comp v2
#        what: an identifier of what the versions belong to.
#        v1: first version
#        comp: comparison
#        v2: second version
# 
# Example:
#    ./compare_versions.sh swig 4.0.2 <= 4.1.0
#
# Compare two versions "v1 ** v2"
# The script echoes:
#     0     if the comparison is false
#     1     if the comparison is true
# ------------------------------

function compare_swig {
	# left-hand side version
	local v1=$1
	# comparison
	local comp=$2
	# right-hand side version
	local v2=$3
	
	local v1_=( $(echo $v1 | tr "." "\n") )
	local v2_=( $(echo $v2 | tr "." "\n") )
	
	lt=0
	eq=0
	gt=0
	
	# test major version
	if [ ${v1_[0]} -lt ${v2_[0]} ]; then
		lt=1
		
	elif [ ${v1_[0]} -gt ${v2_[0]} ]; then
		gt=1
		
	else
		# test minor version
		if [ ${v1_[1]} -lt ${v2_[1]} ]; then
			lt=1
			
		elif [ ${v1_[1]} -gt ${v2_[1]} ]; then
			gt=1
			
		else
			# test patch version
			if [ ${v1_[2]} -lt ${v2_[2]} ]; then
				lt=1
			elif [ ${v1_[2]} -gt ${v2_[2]} ]; then
				gt=1
			else
				eq=1
			fi
		fi
	fi
	
	if [ "$comp" == "<" ]; then
		echo $lt
	elif [ "$comp" == "<=" ]; then
		echo $(( $lt + $eq ))
	elif [ "$comp" == "==" ]; then
		echo $eq
	elif [ "$comp" == ">=" ]; then
		echo $(( $eq + $gt ))
	elif [ "$comp" == ">" ]; then
		echo $gt
	fi
}

# compare the versions of 'what'
what=$1

if [ "$what" == "swig" ]; then
	r=$(compare_swig $2 $3 $4)
	echo $r
fi
