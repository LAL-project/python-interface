#pragma once

// lal includes
#include <lal/basic_types.hpp>
#include <lal/linarr/chunking/chunk.hpp>

// custom includes
#include "auxiliary_classes/generic_iterator.hpp"

/// Iterator over a chunk.
class chunk_iterator : public generic_iterator<
	lal::linarr::chunk,
	lal::node
>
{
public:
	/// Constructor with begin and end iterators.
	chunk_iterator(
		lal::linarr::chunk::iterator b,
		lal::linarr::chunk::iterator e
	)
	noexcept :
		generic_iterator(b, e)
	{}
	
	/// Default destructor.
	~chunk_iterator() noexcept = default;
};
