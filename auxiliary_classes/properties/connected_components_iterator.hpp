#pragma once

// lal includes
#include <lal/graphs/directed_graph.hpp>
#include <lal/graphs/undirected_graph.hpp>
#include <lal/properties/connected_components.hpp>

// custom includes
#include "auxiliary_classes/generic_iterator.hpp"

/* DIRECTED GRAPHS */

/**
 * @brief Iterator over connected components of a graph.
 * @tparam graph_t Type of graph.
 */
template <class graph_t>
class connected_components_iterator : public generic_iterator<
	lal::properties::connected_components<graph_t>,
	graph_t
>
{
public:
	/// Constructor with begin and end iterators.
	connected_components_iterator(
		typename lal::properties::connected_components<graph_t>::iterator b,
		typename lal::properties::connected_components<graph_t>::iterator e
	)
	noexcept :
		generic_iterator<lal::properties::connected_components<graph_t>, graph_t>(b, e)
	{}
	
	/// Default destructor.
	~connected_components_iterator() noexcept = default;
};

/// Typedef so as to shorten the code in properties.i
typedef connected_components_iterator<lal::graphs::directed_graph> connected_components_dg_iterator;
/// Typedef so as to shorten the code in properties.i
typedef connected_components_iterator<lal::graphs::undirected_graph> connected_components_ug_iterator;
