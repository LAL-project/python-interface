#!/bin/bash

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
