export sugiyama, kamadakawai

@recipe(Sugiyama, mainpath, families) do scene
    Theme(edgecolor=:grey80, colormap=:viridis)
end

function Makie.plot!(plt::Sugiyama)
    mainpath = plt[:mainpath]
    families = plt[:families]

    g = mainpath[].mainpath
    y = map(Patents.earliest_filing, families[])

    nodecol = fill(:grey30, nv(g))#; nodecol[mainpath[].start] .= :red
    nodesize = 8 .+ 2 * log.(1 .+ Patents.citedby_count.(families[]))
    marker = fill(:circle, nv(g)); marker[mainpath[].start] .= :cross
    edgecol = plt[:edgecolor]
    
    graphplot!(plt, g, 
        layout=x->igraph_layout_sugiyama(x, y),
        node_color=nodecol, 
        edge_color=edgecol, 
        node_size=nodesize,
        node_marker=marker
    )
end

@recipe(Kamadakawai, mainpath, families) do scene
    Theme(edgecolor=:grey80, colormap=:viridis)
end

function Makie.plot!(plt::Kamadakawai)
    mainpath = plt[:mainpath]
    families = plt[:families]

    g = mainpath[].mainpath
    y = map(Dates.year ∘ Patents.earliest_filing, families[])
 
    marker = fill(:circle, nv(g)); marker[mainpath[].start] .= :cross
    edgecol = plt[:edgecolor]
   
    nodesize = 7 .+ 2 * log.(1 .+ Patents.citedby_count.(families[]))

    graphplot!(plt, g, 
        layout=igraph_layout_kamadakawai,
        node_color=y, 
        edge_color=edgecol, 
        node_size=nodesize,
        node_marker=marker,
        node_attr=(;colormap=plt[:colormap])
    )
end


# function Makie.show_data(inspector::DataInspector, plot::MainPathPlot, idx, ::Scatter)
#     a = inspector.plot.attributes
#     scene = parent_scene(plot)

#     proj_pos = shift_project(scene, plot, to_ndim(Point3f, plot[1][][idx], 0))
#     update_tooltip_alignment!(inspector, proj_pos)
#     ms = plot.markersize[]

#     # a._display_text[] = position2string(plot[1][][idx])
#     a._display_text[] = "some text"
#     a._bbox2D[] = Rect2f(proj_pos .- 0.5 .* ms .- Vec2f(5), Vec2f(ms) .+ Vec2f(10))
#     a._px_bbox_visible[] = true
#     a._bbox_visible[] = false
#     a._visible[] = true

#     return true
# end
