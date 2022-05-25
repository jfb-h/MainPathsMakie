using MainPathsMakie
using Test
using MainPaths
using Graphs
using Patents
using PatentsLens
using Dates
using GLMakie

families, mp = let 
    apps = PatentsLens.read("test/gracilaria.jsonl")
    fams = Patents.aggregate_families(apps)
    citg = Patents.citationgraph(fams)
    strt = partialsortperm(fams, 1:50, by=Patents.citedby_count, rev=true) |> collect
    mp   = MainPaths.mainpath(citg, SPCEdge(:log), ForwardBackwardLocal(strt))
    fams, mp
end

yrs = 1980:5:2020
tickvalues = Dates.datetime2rata.(Date.(yrs)); ticklabels = string.(yrs)
sugiyama(mp, families[mp.vertices], axis=(xticks=(tickvalues, ticklabels),))

fig, ax, p = kamadakawai(mp, families[mp.vertices])
Colorbar(fig[1,2], p.plots[1].plots[3])
fig

# struct DateTicks end

# function Makie.MakieLayout.get_ticks(::DateTicks, ::typeof(identity), ::Makie.Automatic, vmin, vmax)
#     mindate, maxdate = Dates.rata2datetime.(convert.(Int, (vmin, vmax)))
#     dates = Date.(Dates.year(mindate):Dates.year(maxdate))
#     ticklabels = string.(Dates.year.(dates))
#     tickvalues = Dates.datetime2rata(dates)
#     return tickvalues, ticklabels
# end


@testset "MainPathsMakie.jl" begin
    # Write your tests here.
end
