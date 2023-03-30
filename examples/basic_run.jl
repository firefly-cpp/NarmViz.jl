# testing
using NarmViz
using CSV

include("plot.jl")

dataset = CSV.File("intervali.csv") |> DataFrame

create_plots(dataset, 10)
