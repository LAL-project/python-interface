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

%ignore operator<<;
%ignore operator<=>;

%rename(__mod__) operator% (uint64_t) const noexcept;
%rename(__mod__) operator% (const integer&) const noexcept;
%rename(__pow__) power (const uint64_t) const noexcept;
%rename(__pow__) power (const integer&) const noexcept;
%ignore powt;

namespace lal {
namespace numeric {

%ignore integer::integer(mpz_t&&) noexcept;
%ignore integer::integer(integer&&) noexcept;
%ignore integer::set_integer(integer&&) noexcept;
%ignore integer::operator=;
%ignore integer::operator-();

} // -- namespace numeric
} // -- namespace lal

%include "lal/numeric/integer.hpp"

namespace lal {
namespace numeric {

%template (integer) integer::integer<const int64_t>;
%template (set_number) integer::set_number<const int64_t>;
%template (__eq__) integer::operator== <const int64_t>;
%template (__add__) integer::operator+ <const int64_t>;
%template (__sub__) integer::operator- <const int64_t>;
%template (__mul__) integer::operator* <const int64_t>;
%template (__truediv__) integer::operator/ <const int64_t>;
%template (__iadd__) integer::operator+= <const int64_t>;
%template (__isub__) integer::operator-= <const int64_t>;
%template (__imul__) integer::operator*= <const int64_t>;
%template (__itruediv__) integer::operator/= <const int64_t>;

%extend integer {
	bool __le__(const integer& n) const noexcept {
		return *$self <= n;
	}
	bool __lt__(const integer& n) const noexcept {
		return *$self < n;
	}
	bool __ge__(const integer& n) const noexcept {
		return *$self >= n;
	}
	bool __gt__(const integer& n) const noexcept {
		return *$self > n;
	}
	
	bool __le__(int64_t i) const noexcept {
		return *$self <= i;
	}
	bool __lt__(int64_t i) const noexcept {
		return *$self < i;
	}
	bool __ge__(int64_t i) const noexcept {
		return *$self >= i;
	}
	bool __gt__(int64_t i) const noexcept {
		return *$self > i;
	}
	
	std::string __repr__() const {
		return $self->to_string();
	}
}

} // -- namespace numeric
} // -- namespace lal

namespace lal {
namespace numeric {

%ignore rational::rational(integer&&) noexcept;
%ignore rational::rational(integer&&, integer&&) noexcept;
%ignore rational::rational(rational&&) noexcept;
%ignore rational::set_integer(integer&& n, integer&& d) noexcept;
%ignore rational::operator=;
%ignore rational::operator-();

} // -- namespace numeric
} // -- namespace lal

%include "lal/numeric/rational.hpp"

namespace lal {
namespace numeric {

%template (rational) rational::rational<const int64_t>;
%template (set_number) rational::set_number<const int64_t>;
%template (__eq__) rational::operator== <const int64_t>;
%template (__add__) rational::operator+ <const int64_t>;
%template (__sub__) rational::operator- <const int64_t>;
%template (__mul__) rational::operator* <const int64_t>;
%template (__truediv__) rational::operator/ <const int64_t>;
%template (__iadd__) rational::operator+= <const int64_t>;
%template (__isub__) rational::operator-= <const int64_t>;
%template (__imul__) rational::operator*= <const int64_t>;
%template (__itruediv__) rational::operator/= <const int64_t>;

%extend rational {
	bool __le__(const rational& n) const noexcept {
		return *$self <= n;
	}
	bool __lt__(const rational& n) const noexcept {
		return *$self < n;
	}
	bool __ge__(const rational& n) const noexcept {
		return *$self >= n;
	}
	bool __gt__(const rational& n) const noexcept {
		return *$self > n;
	}
	
	bool __le__(const integer& n) const noexcept {
		return *$self <= n;
	}
	bool __lt__(const integer& n) const noexcept {
		return *$self < n;
	}
	bool __ge__(const integer& n) const noexcept {
		return *$self >= n;
	}
	bool __gt__(const integer& n) const noexcept {
		return *$self > n;
	}
	
	bool __le__(int64_t i) const noexcept {
		return *$self <= i;
	}
	bool __lt__(int64_t i) const noexcept {
		return *$self < i;
	}
	bool __ge__(int64_t i) const noexcept {
		return *$self >= i;
	}
	bool __gt__(int64_t i) const noexcept {
		return *$self > i;
	}

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
	r = rational(integer(k), self)
	if r.get_denominator() == 1:
		return r.get_numerator()
	return r
def __rpow__(self, k):
	if k == 0:
		return integer(0)
	if self == 0:
		return integer(1)
	
	if self < 0:
		self_pos = -self
		return rational(integer(1), integer(k)**self_pos)
	
	return integer(k)**self

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
	base = (k**self.get_numerator()).to_double()
	deno = self.get_denominator().to_int()
	return base**(1.0/deno)

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
