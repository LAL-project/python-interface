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

function help() {
	echo "Compilation of the Python wrapper for LAL"
	echo "========================================="
	echo ""
	echo "Optional parameters:"
	echo ""
	echo "    --build=debug                (default)"
	echo "    --build=release"
	echo ""
	echo "        Make either a debug or release compilation of the wrapper."
	echo ""
	echo "    --environment=development    (default)"
	echo "    --environment=distribution"
	echo ""
	echo "        For developers only. 'distribution' will compile the wrapper"
	echo "        against LAL installed in the system. 'development' will compile"
	echo "        the wrapper against a local, non-installed version of LAL."
	echo ""
	echo "    --install"
	echo ""
	echo "        Copy the compiled binaries to the installation directory."
	echo "        Deactivated by default."
	echo ""
	echo "    --anaconda"
	echo ""
	echo "        Compile the python wrapper for anaconda."
	echo "        Deactivated by default."
	echo ""
	echo "Examples of usage:"
	echo ""
	echo "* Make a debug build in a development version of LAL"
	echo ""
	echo "    ./compile.sh --build=debug"
	echo "    ./compile.sh --build=debug --environment=development"
	echo ""
	echo "* Make a release build in a distribution version of LAL"
	echo ""
	echo "    ./compile.sh --build=release --environment=distribution"
	echo ""
	echo "* Install a release compilation of LAL"
	echo ""
	echo "    ./compile.sh --build=release --install"
	echo ""
	exit
}

ANACONDA="no"
BUILD="debug"
ENVIRONMENT="development"
INSTALL=0
CLEAN=0

for i in "$@"; do
	case $i in
		--help)
		help
		;;
		
		--anaconda)
		ANACONDA="yes"
		shift
		;;
		
		--build=*)
		BUILD="${i#*=}"
		shift
		;;
		
		--environment=*)
		ENVIRONMENT="${i#*=}"
		shift
		;;
		
		--clean)
		CLEAN=1
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

if [ $CLEAN == 1 ] && [ $INSTALL == 1 ]; then
	echo "Error: conflict in options '--clean' and '--install'"
	echo "    clean:   $CLEAN"
	echo "    install: $INSTALL"
	exit 1
fi

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
elif [ $CLEAN == 1 ]; then
	make ENVIRONMENT=$ENVIRONMENT BUILD=$BUILD ANACONDA=$ANACONDA clean
else
	make ENVIRONMENT=$ENVIRONMENT BUILD=$BUILD ANACONDA=$ANACONDA
fi
