function igraph_layout_sugiyama(g::AbstractGraph, layers::Union{Nothing, Vector{Date}}=nothing)
    adjmat = adjacency_matrix(g)
    mode = is_directed(g) ? "directed" : "undirected"
    
    lay = isnothing(layers) ? layers : Dates.datetime2rata.(layers)

    R"""
    g = igraph::graph_from_adjacency_matrix($adjmat, mode=$mode)
    l = igraph::layout_with_sugiyama(g, layers=$lay)$layout
    """
    l = @rget l
	if isnothing(lay)
        r = [Point(y, x) for (x, y) in eachrow(l)]
    else 
        r = [Point(x, y) for (x, y) in zip(lay, l[:,1])]
    end
    return r
end

function igraph_layout_kamadakawai(g::AbstractGraph; seed=1234)
    adjmat = adjacency_matrix(g)
    mode = is_directed(g) ? "directed" : "undirected"
    
    R"""
    set.seed($seed)
    g = igraph::graph_from_adjacency_matrix($adjmat, mode=$mode)
    l = igraph::layout_with_kk(g)
    """
    l = @rget l
	return [Point(y, x) for (x, y) in eachrow(l)]
end