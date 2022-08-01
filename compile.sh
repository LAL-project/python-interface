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
	echo "For further information, read below the usage of all parameters."
	echo ""
	echo "----------"
	echo "LAL SOURCE"
	echo "----------"
	echo ""
	echo "    When necessary, the location of the Linear Arrangement Library's"
	echo "    header files and library files can be specified with the following"
	echo "    two commands:"
	echo ""
	echo "    --lal-headers=dir"
	echo ""
	echo "        Use it to specify the location of LAL's header files."
	echo ""
	echo "    --lal-libs=dir"
	echo ""
	echo "        Use it to specify the location of LAL's library files (.so, .dll, ...)."
	echo ""
	echo "----------"
	echo "LAL SOURCE"
	echo "----------"
	echo ""
	echo "    Specify the destination directory of LAL with the following command:"
	echo ""
	echo "    --lal-destination=dir"
	echo ""
	echo "    This is mandatory when using the option '--install'."
	echo ""
	echo "----------"
	echo "GMP SOURCE"
	echo "----------"
	echo ""
	echo "    When necessary, the location of the GNU Multiple Precision library"
	echo "    header files and library files can be specified with the following"
	echo "    two commands:"
	echo ""
	echo "    --gmp-headers=dir"
	echo ""
	echo "        Use it to specify the location of GMP's header files."
	echo ""
	echo "    --gmp-libs=dir"
	echo ""
	echo "        Use it to specify the location of GMP's library files (.so, .dll, ...)."
	echo ""
	echo "-------------"
	echo "PYTHON SOURCE"
	echo "-------------"
	echo ""
	echo "    When necessary, the location of python's header files and library"
	echo "    files can be specified with the following two commands:"
	echo ""
	echo "    --python-headers=dir"
	echo ""
	echo "        Use it to specify the location of GMP's header files."
	echo ""
	echo "    --python-libs=dir"
	echo ""
	echo "        Use it to specify the location of GMP's library files (.so, .dll, ...)."
	echo ""
	echo "    It is mandatory to specify the version of python that is to be used"
	echo ""
	echo "    --python-major=x    (default: 3)"
	echo "    --python-minor=x"
	echo ""
	echo "----------------"
	echo "BUILD PARAMETERS"
	echo "----------------"
	echo ""
	echo "    --build=debug                (default)"
	echo "    --build=release"
	echo ""
	echo "        Make either a debug or release compilation of the wrapper."
	echo ""
	echo "------------------"
	echo "INSTALL PARAMETERS"
	echo "------------------"
	echo ""
	echo "    --install"
	echo ""
	echo "        Copy the compiled binaries to the installation directory."
	echo ""
	echo "    --anaconda"
	echo ""
	echo "        Install for anaconda"
	echo ""
	exit
}

LAL_HEADERS=""
LAL_LIBRARY=""
LAL_DESTINATION=""
GMP_HEADERS=""
GMP_LIBRARY=""
PYTHON_HEADERS=""
PYTHON_LIBRARY=""
PYTHON_MAJOR="3"
PYTHON_MINOR=""
BUILD="debug"
ENVIRONMENT="development"
INSTALL=0
ANACONDA="no"
CLEAN=0

for i in "$@"; do
	case $i in
		--help)
		help
		;;
		
		--lal-headers=*)
		LAL_HEADERS="${i#*=}"
		shift
		;;
		
		--lal-libs=*)
		LAL_LIBRARY="${i#*=}"
		shift
		;;
		
		--lal-destination=*)
		LAL_DESTINATION="${i#*=}"
		shift
		;;
		
		--gmp-headers=*)
		GMP_HEADERS="${i#*=}"
		shift
		;;
		
		--gmp-libs=*)
		GMP_LIBRARY="${i#*=}"
		shift
		;;
		
		--python-headers=*)
		PYTHON_HEADERS="${i#*=}"
		shift
		;;
		
		--python-libs=*)
		PYTHON_LIBRARY="${i#*=}"
		shift
		;;
		
		--python-major=*)
		PYTHON_MAJOR="${i#*=}"
		shift
		;;
		
		--python-minor=*)
		PYTHON_MINOR="${i#*=}"
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
		
		--anaconda)
		ANACONDA="yes"
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

if [ $INSTALL == 1 ]; then
	if [ $LAL_DESTINATION == "" ]; then
		echo "Error: missing mandatory value for option 'install'."
		echo "    Missing: --lal-destination"
		echo "    Current value: $LAL_DESTINATION"
		exit 1
	fi
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

MAKE_COMMAND="\
make \
USER_LAL_INC_DIR=$LAL_HEADERS \
USER_LAL_LIB_DIR=$LAL_LIBRARY \
USER_LAL_DESTINATION=$LAL_DESTINATION \
USER_GMP_INC_DIR=$GMP_HEADERS \
USER_GMP_LIB_DIR=$GMP_LIBRARY \
USER_PYTHON_HEADERS=$PYTHON_HEADERS \
USER_PYTHON_LIBRARY=$PYTHON_LIBRARY \
USER_PYTHON_MAJOR_VERSION=$PYTHON_MAJOR \
USER_PYTHON_MINOR_VERSION=$PYTHON_MINOR \
USER_ENVIRONMENT=$ENVIRONMENT \
USER_BUILD=$BUILD \
USER_ANACONDA=$ANACONDA"

echo "Make command: '$MAKE_COMMAND'"

if [ $INSTALL == 1 ]; then
	$MAKE_COMMAND install
elif [ $CLEAN == 1 ]; then
	$MAKE_COMMAND clean
else
	$MAKE_COMMAND
fi
