module NarmViz

using CSV
using DataFrames
using DataFramesMeta
using Plots
using Random
using StatsPlots

export create_plots, calculate_points, calculate_ylim, select_feature

include("plot.jl")

end

# testing
using CSV
using DataFrames
using DataFramesMeta
using Plots
using Random
using StatsPlots

include("plot.jl")

dataset = CSV.File("intervali.csv") |> DataFrame

create_plots(dataset, 10)
