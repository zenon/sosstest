### A Pluto.jl notebook ###
# v0.11.6

using Markdown
using InteractiveUtils

# ╔═╡ b086ae50-de5e-11ea-032c-477b0fc4e04a
begin
	if !endswith(pwd(), "soss")
		cd("soss")
	end
	using Pkg
	Pkg.activate("c:\\projects\\plutoJL\\soss")
	using Random, Distributions, Soss
	Random.seed!(3)
	using Plots, StatsPlots
end

# ╔═╡ 1d8a24e0-df28-11ea-1c01-ebed0f6c0005
md"""## We expect that oak trees grow linearly in time.

Of course not exactly. This means, that the size of the tree in meters will depend on the age in years linearly, but not exactly so.

Linear: $size = a\cdot age$

As we don't know much yet, we start with modelling the _not exactly so_ part with a normal distribution with some guessed parameters. All of this can be refined later.

$size = Normal(a\cdot age, 0.5)$

With this formula, $a$ is the average growth rate for our oaks. As we don't know it, we model it as some unknown value between 0.1 and 2.

""" 

# ╔═╡ 3c9a90f0-dfc7-11ea-1ac1-83faa6c03e65
m1 = @model age begin
	a = 7.0 # ~ Uniform(0.1, 2.0)
    size ~ For(eachrow(age)) do x
		# eachrow gives an array type, so we take the value out of it with x[1]
        Normal(a * x[1], 1.0)
    end
end

# ╔═╡ 221d2f60-dfc9-11ea-07c1-bde472ab0b27
md"Let's look at what this gives for a range of ages."

# ╔═╡ 436cdd50-dfc9-11ea-3221-b152012d599c
ages = collect(range(1.0, 200.0, length = 100))

# ╔═╡ 96481b70-dfc9-11ea-09c3-5bd62e0f1989
md"Now we put these into the model, to see what it thinks a priori."

# ╔═╡ 91293980-dfc9-11ea-069a-3f81dccb342b
m1Forward = m1(age = ages)

# ╔═╡ dac44da0-dfc9-11ea-3f34-2d28d5a8b19e
priorSimulation = rand(m1Forward)

# ╔═╡ 459083d0-dfcd-11ea-1b77-19c166be3a11
pairs(priorSimulation)

# ╔═╡ 4b9afe40-dfcd-11ea-1564-9f00dcdfdd0a


# ╔═╡ Cell order:
# ╠═b086ae50-de5e-11ea-032c-477b0fc4e04a
# ╠═1d8a24e0-df28-11ea-1c01-ebed0f6c0005
# ╠═3c9a90f0-dfc7-11ea-1ac1-83faa6c03e65
# ╠═221d2f60-dfc9-11ea-07c1-bde472ab0b27
# ╠═436cdd50-dfc9-11ea-3221-b152012d599c
# ╠═96481b70-dfc9-11ea-09c3-5bd62e0f1989
# ╠═91293980-dfc9-11ea-069a-3f81dccb342b
# ╠═dac44da0-dfc9-11ea-3f34-2d28d5a8b19e
# ╠═459083d0-dfcd-11ea-1b77-19c166be3a11
# ╠═4b9afe40-dfcd-11ea-1564-9f00dcdfdd0a
