module NarmViz

using CSV
using DataFrames
using NiaARM
using StatsPlots
using StatsBase

export visualize, plotattribute, plotfeature
export VizType, Scatter, Bar, Line, Boxplot, Violin, Hexbin

include("utils.jl")
include("types.jl")
include("viz_types/mosaic.jl")
include("viz_types/scatter.jl")
include("viz_types/barchart.jl")
include("viz_types/linechart.jl")
include("viz_types/boxplot.jl")
include("viz_types/violin.jl")
include("viz_types/hexbin.jl")
include("visualize.jl")

end
