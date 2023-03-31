Base.@kwdef mutable struct Settings
    features::Union{Vector{String},String}
    ignore_features::Vector{String}
    interval::String
    antecedents::Bool = true
    consequence::Bool = true
    antecedent_color = :blue
    consequence_color = :red
    title::String = "Visualization"
    output_path::String
end
