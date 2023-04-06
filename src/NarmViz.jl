module NarmViz

using CSV
using DataFrames
using DataFramesMeta
using Plots
using Random
using StatsPlots

export Attribute,
    Settings,
    Transactions,
    create_plots,
    calculate_points,
    select_feature,
    getfeaturenames,
    getcolumnvalues,
    calculate_area,
    visualize

include("attribute.jl")
include("transactions.jl")
include("settings.jl")
include("narm.jl")
include("visualize.jl")

end
