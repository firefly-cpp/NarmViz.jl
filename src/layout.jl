Base.@kwdef mutable struct Layout
    features::Vector{String}
    antecedents::Bool = true
    consequence::Bool = true
    title::String = "Visualization"
end
