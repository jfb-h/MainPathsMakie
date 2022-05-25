### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# ╔═╡ 82d7da60-d9f2-11ec-02d2-d9f6ff8ef751
using Pkg; Pkg.activate("")

# ╔═╡ 5eae47b2-b1c5-44ec-b85d-04db5d4e400a
begin
	using GLMakie
	using MainPaths
	using MainPathsMakie
	using Patents
	using PatentsLens
	using Graphs
end

# ╔═╡ fe29fe90-4fc8-4d4b-9276-83ea9e082701
md"""
# MainPathMakie Test
"""

# ╔═╡ 89b1e8f4-e3d0-4391-9d60-63f14753aeb9
apps = PatentsLens.read("gracilaria.jsonl")

# ╔═╡ 7e65ee94-d41f-4528-a7e9-708a6974eae3
families = Patents.aggregate_families(apps)

# ╔═╡ d4995875-e293-4703-a158-698569a2d090
citgraph = Patents.citationgraph(families)

# ╔═╡ 52b715e8-7423-46fc-b4e1-83d15a5dd1e9
start = partialsortperm(degree(citgraph), 1:5, rev=true) |> collect

# ╔═╡ 034f024a-57a2-4569-8180-aa7db4412fa8
mp = mainpath(citgraph, SPCEdge(:log), ForwardBackwardLocal(start))

# ╔═╡ b578952c-abe3-4ddd-9bb0-c1042699014a
let fig = Figure(resolution=(800, 1000))
	ax1 = Axis(fig[1,1]); ax2 = Axis(fig[2,1])
	hideydecorations!(ax1); hidedecorations!(ax2)
	sugiyama!(ax1, mp, families[mp.vertices])
	kamadakawai!(ax2, mp, families[mp.vertices])
	fig
end

# ╔═╡ Cell order:
# ╟─fe29fe90-4fc8-4d4b-9276-83ea9e082701
# ╠═82d7da60-d9f2-11ec-02d2-d9f6ff8ef751
# ╠═5eae47b2-b1c5-44ec-b85d-04db5d4e400a
# ╠═89b1e8f4-e3d0-4391-9d60-63f14753aeb9
# ╠═7e65ee94-d41f-4528-a7e9-708a6974eae3
# ╠═d4995875-e293-4703-a158-698569a2d090
# ╠═52b715e8-7423-46fc-b4e1-83d15a5dd1e9
# ╠═034f024a-57a2-4569-8180-aa7db4412fa8
# ╠═b578952c-abe3-4ddd-9bb0-c1042699014a
