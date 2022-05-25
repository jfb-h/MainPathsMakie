function _mainpathplot(mp::MainPaths.MainPathResult, fam::Vector{Family}; layout=:kamadakawai)
    g = mp.mainpath
    v = mp.vertices
    years = Dates.year.(earliest_filing.(fam[mp.vertices]))

    labels = string.(v)

    symbol = [:circle for _ in 1:length(v)]
    symbol[mp.start] .= :cross

    sizes = [5 for _ in 1:length(v)]
    sizes[mp.start] .= 10

    ynorm = years .- minimum(years) .+ 1
    col = cgrad(:viridis, maximum(years) - minimum(years) + 1, categorical=true)


    function layout_sugiyama(g)
        y = Dates.year.(earliest_filing.(fam[mp.vertices]))
        p = igraph_layout_sugiyama(g; layers=y)
        Point.(maximum(y) .- first.(p) .+ 1, last.(p))
    end

    if layout == :kamadakawai
        layoutfun = igraph_layout_kamadakawai
    elseif layout == :sugiyama
        layoutfun = layout_sugiyama
    else
        error("layout needs to be one of :kamadakawai or :sugiyama.")
    end

    fig, ax, plt = graphplot(g, layout=layoutfun, 
        nlabels=labels, 
        nlabels_textsize=0,
        node_color=col[ynorm],
        node_marker=symbol,
        node_attr=(strokewidth=1, strokecolor=:black),
        edge_color=:grey80,
        node_size=sizes,
        arrow_size=5
    )
    
    if layout == :kamadakawai 
        hidespines!(ax)
        hidedecorations!(ax)
    else
        hidespines!(ax, :l, :r, :t)
        hideydecorations!(ax)
    end

    Colorbar(fig[1,2], 
        limits = (minimum(years), maximum(years)), 
        colormap = :viridis,
        height=Relative(.5),
        ticklabelsize=10)

    function node_hover_action(state, idx, event, axis)
        plt.node_size[][idx] = state ? plt.node_size[][idx] * 2 : plt.node_size[][idx] / 2
        plt.node_size[] = plt.node_size[] # trigger observable
    end

    function node_click_action(idx, args...)
        println("Index: $idx")
        show(stdout, "text/plain", fams[mp.vertices[idx]])
    end

    nhover = NodeHoverHandler(node_hover_action)
    nclick = NodeClickHandler(node_click_action)
    
    deregister_interaction!(ax, :rectanglezoom)
    
    register_interaction!(ax, :nhover, nhover)
    register_interaction!(ax, :nclick, nclick)

    fig, ax, plt
end

function mainpathplot(mp::MainPaths.MainPathResult, fam::Vector{Family}; layout=:kamadakawai) 
    fig, ax, plt = _mainpathplot(mp, fam, layout=layout)
    fig
end

function mainpathplot(
    mp::MainPaths.MainPathResult, 
    fam::Vector{Family},
    seg::MainPaths.MainPathSegment;
    layout=:kamadakawai)

    fig, ax, p = _mainpathplot(mp, fam, layout=layout)
    newcols = p.attributes.node_color[]
    newcols[seg.intermediates] .= Makie.RGBA{Float64}(.9, .1, .2, 1.0)
    p.attributes.node_color = newcols

    fig
end