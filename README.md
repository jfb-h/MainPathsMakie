# MainPathsMakie

This package contains [Makie.jl](https://github.com/JuliaPlots/Makie.jl) recipes to plot your `MainPathsResult` (from [`MainPaths.jl`](https://github.com/jfb-h/MainPaths.jl)) and a corresponding `Vector{Family}` (from from [`Patents.jl`](https://github.com/jfb-h/Patents.jl)).
Its two main functions are `sugiyama(mainpath, families)` and `kamadakawai(mainpath, families)`, which generate graph plots with the correspondingly named layouts.

The package relies on the `igraph` R package for graph layouting via `RCall.jl`, so R and igraph need to be installed on the system. 
