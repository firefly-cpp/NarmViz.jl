module NarmViz

using CSV
using DataFrames
using DataFramesMeta
using Plots
using Random
using StatsPlots

export Attribute,
    Layout,
    Transactions,
    create_plots,
    calculate_points,
    select_feature,
    getfeaturenames,
    if_antecedent,
    if_consequence,
    calculate_area,
    visualize

include("attribute.jl")
include("transactions.jl")
include("layout.jl")
include("narm.jl")
include("visualize.jl")

end
