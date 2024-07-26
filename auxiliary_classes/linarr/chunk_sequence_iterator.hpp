#pragma once

// lal includes
#include <lal/linarr/chunking/chunk.hpp>
#include <lal/linarr/chunking/chunk_sequence.hpp>

// custom includes
#include "auxiliary_classes/generic_iterator.hpp"

/// Iterator over a chunk sequence.
class chunk_sequence_iterator : public generic_iterator<
	lal::linarr::chunk_sequence,
	lal::linarr::chunk
>
{
public:
	/// Constructor with begin and end iterators.
	chunk_sequence_iterator(
		lal::linarr::chunk_sequence::iterator b,
		lal::linarr::chunk_sequence::iterator e
	)
	noexcept :
		generic_iterator(b, e)
	{}
	
	/// Default destructor.
	~chunk_sequence_iterator() noexcept {}
};
