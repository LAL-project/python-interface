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

PYTHON=""
if ! command -v python &> /dev/null
then
	PYTHON=python3
else
	PYTHON=python
fi

D=modules/documentation.i

####################################################################

echo -e "\e[1;1;33mLooking for malformed mathematical expressions...\e[0m"
$PYTHON scripts/detect_superfluous_spaces_math.py $D | sed "s/^/    /g"
if [ $? -eq 1 ]; then
	echo -e "\e[1;4;31mError:\e[0m Found malformed mathematical expressions"
	echo -e "Rerun the script \e[1;4;31monce you have corrected them\e[0m"
	exit
fi

echo -e "\e[1;1;33mFormat 'Parameters' title appropriately\e[0m"
sed -E 's/Parameters:/Parameters:ª/g' $D | tr 'ª' '\n' > /tmp/asdf
mv /tmp/asdf $D

echo -e "\e[1;1;33mCorrecting math delimiters\e[0m"
$PYTHON scripts/correct_math_delimiters.py $D | sed "s/^/    /g"

# Clean up strings produced by 'documentation.i'
# These are found in the documentation of overloaded functions.

echo -e "\e[1;1;33mRemove return types from functions\e[0m"
sed -i 's/) -> .*`/)`/g' $D
