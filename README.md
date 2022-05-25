# MainPathsMakie

This package contains `Makie.jl` recipes to plot your `MainPathsResult` (from `MainPaths.jl`) and a corresponding `Vector{Family}` (from `Patents.jl`).
Its two main functions are `sugiyama(mainpath, families)` and `kamadakawai(mainpath, families)`, which generate graph plots with the corresponding layouts.

The package relies on the `igraph` R package for graph layouting via `RCall.jl`, so R and igraph need to be installed on the system. 
