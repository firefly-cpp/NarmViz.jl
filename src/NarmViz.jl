module NarmViz

using CSV
using DataFrames
using Plots
using NiaARM

export visualize, plotattribute, plotfeature

include("utils.jl")
include("viz_types/mosaic.jl")
include("viz_types/scatter.jl")
include("viz_types/barchart.jl")
include("viz_types/linechart.jl")
include("visualize.jl")

end
