#!/usr/bin/env python
# -*- coding: utf-8 -*-

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

from sys import argv
import re

def find_matching_strings(all_expressions, regexpr):
	found = False
	for expr in all_expressions:
		iterator = space_begin.finditer(expr)
		for match in iterator:
			begin,end = match.span()
			print("ERROR: matched math expression with superfluous spaces!")
			print("--->", expr)
			found = True
	return found

whole_file = ""
with open(argv[1], 'r') as f:
	for line in f: whole_file += line
	f.close()

correct_expressions = re.compile('$([^$]*)$', re.IGNORECASE)
iterator_expressions = correct_expressions.finditer(whole_file)
all_expressions = []
for expression in iterator_expressions:
	begin,end = expression.span()
	all_expressions.append(whole_file[begin:end])

space_begin = re.compile('$ +([^$]*)$', re.IGNORECASE)
space_beginend = re.compile('$ +([^$]*) +$', re.IGNORECASE)
space_end = re.compile('$([^$]*)\ +$', re.IGNORECASE)

found1 = find_matching_strings(all_expressions, space_begin)
found2 = find_matching_strings(all_expressions, space_beginend)
found3 = find_matching_strings(all_expressions, space_end)

if found1 or found2 or found3: exit(1)
