#pragma once

/*
This class is based on

	https://stackoverflow.com/a/35318045/12075306
*/

// C++ includes
#include <optional>

/**
 * @brief New type of exception.
 * 
 * The exception the @ref generic_iterator will return when the iteration
 * is supposed to end.
 */
class StopIteration { };

/**
 * @brief Generic iterator.
 * 
 * Iterator over a generic container @e container_t which contains elements
 * of type @e contained_t.
 * @tparam container_t Iterated container.
 * @tparam contained_t Iterated elements.
 */
template <class container_t, class contained_t>
class generic_iterator {
public:
	/// Constructor with begin and end iterators.
	generic_iterator(
		typename container_t::iterator _begin,
		typename container_t::iterator _end
	)
	noexcept :
		m_current(_begin),
		m_end(_end)
	{
	}
	
	/// Default destructor.
	virtual ~generic_iterator() noexcept = default;
	
	/// Method for python to recognize this as an iterator object.
	generic_iterator *__iter__() noexcept {
		return this;
	}
	
	/// This method returns the next element in the sequence while avoiding
	/// throwing an exception. If this method were to throw, python would
	/// crash.
	std::optional<contained_t> next() noexcept {
		if (m_current != m_end) {
			return *m_current++;
		}
		return {};
	}
	
	/// This method is used by python to control the range-based for loops
	/// incolving @e container_t and @e contained_t.
	contained_t __next__() {
		const std::optional<contained_t> r = next();
		if (r.has_value()) {
			return *r;
		}
		throw StopIteration();
	}

private:
	/// Pointer to the current element.
	typename container_t::iterator m_current;
	/// Pointer to the end of the sequence.
	typename container_t::iterator m_end;
};
