function plotattribute(
    attribute::Union{NumericalAttribute,CategoricalAttribute},
    transactions::DataFrame,
    plot_type::String,
    isantecedent::Bool
)
    if attribute isa CategoricalAttribute
        return plot_categorical_attribute(attribute, transactions, isantecedent)
    elseif attribute isa NumericalAttribute
        if plot_type == "scatter"
            return plot_scatter_num_attribute(attribute, transactions, isantecedent)
        end
    end

    @assert false "Unsupported plot type for attribute: $plot_type"
end

function plotfeature(
    feature::Union{NumericalFeature,CategoricalFeature},
    transactions::DataFrame,
    plot_type::String
)
    if feature isa CategoricalFeature
        return plot_categorical_feature(feature, transactions)
    elseif feature isa NumericalFeature
        if plot_type == "scatter"
            return plot_scatter_num_feature(feature, transactions)
        end
    end
    
    @assert false "Unsupported plot type for feature: $plot_type"
end

function visualize(
    rule::Rule,
    data::Union{DataFrame,Dataset};
    path::Union{String,Nothing}=nothing,
    allfeatures::Bool=false,
    antecedent::Bool=true,
    consequent::Bool=true,
    timeseries::Bool=false,
    intervalcolumn::String="interval",
    interval::Int64=0,
    plot_type::String="scatter"
)
    # Use passed transactions right away, or extract transactions if dataset is passed
    transactions = data isa Dataset ? data.transactions : data

    df = transactions[:, :] # make copy
    if timeseries
        subset!(df, intervalcolumn => i -> i .== interval)
        select!(df, Not([intervalcolumn]))
    end

    plots = []

    if antecedent
        for attribute in rule.antecedent
            push!(plots, plotattribute(attribute, df, plot_type, true))
        end
    end

    if consequent
        for attribute in rule.consequent
            push!(plots, plotattribute(attribute, df, plot_type, false))
        end
    end

    if allfeatures
        if antecedent
            select!(df, Not([attr.name for attr in rule.antecedent]))
        end

        if consequent
            select!(df, Not([attr.name for attr in rule.consequent]))
        end

        features = NiaARM.getfeatures(df)
        for feature in features
            push!(plots, plotfeature(feature, df, plot_type))
        end
    end

    plt = plot(plots..., layout=length(plots))

    if isnothing(path)
        display(plt)
    else
        savefig(plt, path)
    end
end
