module NarmViz

using CSV
using DataFrames
using NiaARM
using StatsPlots

export visualize, plotattribute, plotfeature
export VizType, Scatter, Bar, Line, Boxplot, Violin

include("utils.jl")
include("types.jl")
include("viz_types/mosaic.jl")
include("viz_types/scatter.jl")
include("viz_types/barchart.jl")
include("viz_types/linechart.jl")
include("viz_types/boxplot.jl")
include("viz_types/violin.jl")
include("visualize.jl")

end
