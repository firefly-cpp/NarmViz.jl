using NarmViz
using CSV
using DataFrames
using DataFramesMeta
using Plots
using Random
using StatsPlots
using Test

@testset verbose = true "NarmViz.jl Tests" begin
    include("test_transactions.jl")
end
