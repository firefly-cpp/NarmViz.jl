Base.@kwdef mutable struct Settings
    all_features::Bool = false
    timeseries::Bool = false
    interval::String
    antecedents::Bool = true
    consequence::Bool = true
    antecedent_color = :blue
    consequence_color = :red
    title::String = "Visualization"
    output_path::String
end
