using NarmViz
using CSV
using DataFrames
using Plots
using Test

@testset verbose = true "NarmViz.jl Tests" begin
    include("test_transactions.jl")
end
