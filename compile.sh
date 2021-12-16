#!/bin/bash

###########################################################################
#
#    SWIG-generated python wrapper for the Linear Arrangement Library
#    Copyright (C) 2021 Lluís Alemany Puig
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

ANACONDA="no"
BUILD="debug"
ENVIRONMENT="development"
INSTALL=0

for i in "$@"; do
	case $i in
		--anaconda)
		ANACONDA="yes"
		shift
		;;
		
		--build=*)
		BUILD="${i#*=}"
		shift
		;;
		
		--envir=*)
		ENVIRONMENT="${i#*=}"
		shift
		;;
		
		--install)
		INSTALL=1
		shift
		;;
		
		*)
		echo -e "\e[1;4;31mError:\e[0m Option $i unknown"
		exit 1
		;;
	esac
done

if [ "$ANACONDA" != "no" ] && [ "$ANACONDA" != "yes" ]; then
	echo "Error: invalid value for 'ANACONDA' variable: '$ANACONDA'"
	echo "    Valid values: yes/no"
	exit 1
fi

if [ "$BUILD" != "debug" ] && [ "$BUILD" != "release" ]; then
	echo "Error: invalid value for 'BUILD' variable: '$BUILD'"
	echo "    Valid values: debug/release"
	exit 1
fi

if [ "$ENVIRONMENT" != "development" ] && [ "$ENVIRONMENT" != "distribution" ]; then
	echo "Error: invalid value for 'ENVIRONMENT' variable: '$ENVIRONMENT'"
	echo "    Valid values: development/distribution"
	exit 1
fi

if [ $INSTALL == 1 ]; then
	make ENVIRONMENT=$ENVIRONMENT BUILD=$BUILD ANACONDA=$ANACONDA install
else
	make ENVIRONMENT=$ENVIRONMENT BUILD=$BUILD ANACONDA=$ANACONDA
fi
