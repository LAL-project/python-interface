#!/usr/bin/env python
# -*- coding: utf-8 -*-

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

from sys import argv
import re

f = open(argv[1], 'r')
whole_file = ""
for line in f: whole_file += line
f.close()

last_match_end = 0
new_file = ""

p = re.compile('\$([^\$]*)\$', re.IGNORECASE)
iterator = p.finditer(whole_file)
for match in iterator:
	begin,end = match.span()
	before_expr = whole_file[(last_match_end+1):begin]
	inside_expr = whole_file[begin+1:end-1]
	
	new_file += before_expr + ":math:`" + inside_expr + "` "
	
	last_match_end = end

new_file += whole_file[last_match_end+1:]

f = open(argv[1], 'w')
f.write(new_file)
f.close()
