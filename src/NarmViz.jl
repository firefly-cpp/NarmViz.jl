module NarmViz

using CSV
using DataFrames
using Plots
using NiaARM

export visualize, plotattribute, plotfeature

include("utils.jl")
include("viz_types/mosaic.jl")
include("viz_types/scatter.jl")
include("visualize.jl")

end
