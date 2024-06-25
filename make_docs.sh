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
#        Lluís Alemany Puig (lluis.alemany.puig@upc.edu)
#            LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
#            CQL (Complexity and Quantitative Linguistics Lab)
#            Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
#            Webpage: https://cqllab.upc.edu/people/lalemany/
#
###########################################################################

#!/bin/bash

PYTHON=""
if command -v python3 &> /dev/null
then
	PYTHON=python3
else
	PYTHON=python
fi

echo "Python command to be used is: '$PYTHON'"

# Remember that 
#
#      | sed "s/^/    /g"
#
# indents the output of a program!!

echo -e "\e[1;1;32mGenerating Doxygen (html) documentation of the C++ code...\e[0m"
doxygen doxyconfig/doxyfile | sed "s/^/    /g"

####################################################################

echo -e "\e[1;1;32mParsing XML files with 'doxy2swig.py' to generate some Python documentation\e[0m"
$PYTHON doxyconfig/doxy2swig.py -w 80000 -c -o -a docshtml/xml/index.xml modules/documentation.i | sed "s/^/    /g"

####################################################################

echo -e "\e[1;1;32mClean up documentation.i\e[0m"
scripts/clean_up_documentationi.sh | sed "s/^/    /g"

if [ ! -z $1 ] && [ "$1" == "interface" ]; then
	LAL_HEADERS="../linear-arrangement-library"
	LAL_LIBRARY_RELEASE="../linear-arrangement-library/lal-release"
	LAL_LIBRARY_DEBUG="../linear-arrangement-library/lal-debug"
	ENVIRONMENT=development
	PYTHON_HEADERS="/usr/include/python3.10"
	
	OPTIONS="\
	USER_LAL_INC_DIR=$LAL_HEADERS \
	USER_LAL_LIB_DIR=$LAL_LIBRARY \
	USER_INSTALLATION_DIR=$INSTALLATION_DIR \
	USER_PYTHON_HEADERS=$PYTHON_HEADERS \
	USER_ENVIRONMENT=$ENVIRONMENT"
	
	make $OPTIONS BUILD=release python_interfaces | sed "s/^/        /g"
fi
