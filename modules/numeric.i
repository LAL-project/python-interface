/**************************************************************************
 *
 * SWIG-generated python wrapper for the Linear Arrangement Library
 * Copyright (C) 2021 - 2024 Lluís Alemany Puig
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 * Contact:
 *
 *     Lluís Alemany Puig (lluis.alemany.puig@upc.edu)
 *         LQMC (Quantitative, Mathematical, and Computational Linguisitcs)
 *         CQL (Complexity and Quantitative Linguistics Lab)
 *         Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
 *         Webpage: https://cqllab.upc.edu/people/lalemany/
 *
 *************************************************************************/

%module numeric

%include stdint.i
%include std_string.i

%include documentation.i

%{
// C++ includes
#include <sstream>

// lal includes
#include <lal/numeric.hpp>
%}

namespace lal {
namespace numeric {

%ignore operator<<;
%ignore integer::operator-();
%ignore rational::operator-();
%ignore integer::operator=;
%ignore rational::operator=;

%rename(__mod__) operator% (uint64_t) const noexcept;
%rename(__mod__) operator% (const integer&) const noexcept;
%rename(__pow__) power (uint64_t) const noexcept;
%rename(__pow__) power (const integer&) const noexcept;

} // -- namespace numeric
} // -- namespace lal

namespace lal {
namespace numeric {

	%ignore integer::integer(mpz_t&&) noexcept;
	%ignore integer::integer(integer&&) noexcept;
	%ignore integer::operator=;
	%ignore integer::operator==;
	
} // -- namespace numeric
} // -- namespace lal

%include "lal/numeric/integer.hpp"

namespace lal {
namespace numeric {

	%template (integer) integer::integer<int64_t, std::enable_if_t<true, bool> = true>;
	%template (set_number) integer::set_number<int64_t, std::enable_if_t<true, bool> = true>;
	%template (__eq__) integer::operator== <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__neq__) integer::operator!= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__lt__) integer::operator< <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__le__) integer::operator<= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__gt__) integer::operator> <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__ge__) integer::operator>= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__add__) integer::operator+ <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__sub__) integer::operator- <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__mul__) integer::operator* <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__truediv__) integer::operator/ <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__iadd__) integer::operator+= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__isub__) integer::operator-= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__imul__) integer::operator*= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__itruediv__) integer::operator/= <int64_t, std::enable_if_t<true, bool> = true>;
	
} // -- namespace numeric
} // -- namespace lal

namespace lal {
namespace numeric {

	%ignore rational::rational(integer&&) noexcept;
	%ignore rational::rational(integer&&, integer&&) noexcept;
	%ignore rational::rational(rational&&) noexcept;
	%ignore rational::operator=;
	%ignore rational::operator==;
	
} // -- namespace numeric
} // -- namespace lal

%include "lal/numeric/rational.hpp"

namespace lal {
namespace numeric {

	%template (rational) rational::rational<int64_t, std::enable_if_t<true, bool> = true>;
	%template (set_number) rational::set_number<int64_t, std::enable_if_t<true, bool> = true>;
	%template (__eq__) rational::operator== <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__neq__) rational::operator!= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__lt__) rational::operator< <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__le__) rational::operator<= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__gt__) rational::operator> <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__ge__) rational::operator>= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__add__) rational::operator+ <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__sub__) rational::operator- <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__mul__) rational::operator* <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__truediv__) rational::operator/ <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__iadd__) rational::operator+= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__isub__) rational::operator-= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__imul__) rational::operator*= <int64_t, std::enable_if_t<true, bool> = true>;
	%template (__itruediv__) rational::operator/= <int64_t, std::enable_if_t<true, bool> = true>;

} // -- namespace numeric
} // -- namespace lal

namespace lal {
namespace numeric {

%extend integer {

	std::string __repr__() const {
		return $self->to_string();
	}

}

%extend rational {

	std::string __repr__() const {
		return $self->to_string();
	}

}

} // -- namespace numeric
} // -- namespace lal

%pythoncode %{

def __radd__(self, k):
	return self + k
def __rsub__(self, k):
	return -self + k
def __rmul__(self, k):
	return self * k
def __rtruediv__(self, k):
	return k/self.to_int()
def __rpow__(self, k):
	return k**self.to_int()

setattr(integer, __radd__.__name__, __radd__)
setattr(integer, __rsub__.__name__, __rsub__)
setattr(integer, __rmul__.__name__, __rmul__)
setattr(integer, __rtruediv__.__name__, __rtruediv__)
setattr(integer, __rpow__.__name__, __rpow__)

del __radd__
del __rsub__
del __rmul__
del __rtruediv__
del __rpow__

def __radd__(self, k):
	return self + k
def __rsub__(self, k):
	return -self + k
def __rmul__(self, k):
	return self * k
def __rtruediv__(self, k):
	copyself = rational(self)
	copyself.invert()
	return k*copyself
def __rpow__(self, k):
	return (k**self.get_numerator())**(1.0/(self.get_denominator().to_int()))

setattr(rational, __radd__.__name__, __radd__)
setattr(rational, __rsub__.__name__, __rsub__)
setattr(rational, __rmul__.__name__, __rmul__)
setattr(rational, __rtruediv__.__name__, __rtruediv__)
setattr(rational, __rpow__.__name__, __rpow__)

del __radd__
del __rsub__
del __rmul__
del __rtruediv__
del __rpow__

%}
