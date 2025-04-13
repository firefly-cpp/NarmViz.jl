include("utils.jl")
include("viz_types/mosaic.jl")
include("viz_types/scatter.jl")

function plotattribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
    return plot_numerical_attribute(attribute, transactions, isantecedent)
end

function plotattribute(attribute::CategoricalAttribute, transactions::DataFrame, isantecedent::Bool)
    return plot_categorical_attribute(attribute, transactions, isantecedent)
end

function plotfeature(feature::NumericalFeature, transactions::DataFrame)
    return plot_numerical_feature(feature, transactions)
end

function plotfeature(feature::CategoricalFeature, transactions::DataFrame)
    return plot_categorical_feature(feature, transactions)
end

function visualize(
    rule::Rule,
    transactions::DataFrame;
    path::Union{String,Nothing}=nothing,
    allfeatures::Bool=false,
    antecedent::Bool=true,
    consequent::Bool=true,
    timeseries::Bool=false,
    intervalcolumn::String="interval",
    interval::Int64=0
)
    df = transactions[:, :] # make copy
    if timeseries
        subset!(df, intervalcolumn => i -> i .== interval)
        select!(df, Not([intervalcolumn]))
    end

    plots = []

    if antecedent
        for attribute in rule.antecedent
            push!(plots, plotattribute(attribute, df, true))
        end
    end

    if consequent
        for attribute in rule.consequent
            push!(plots, plotattribute(attribute, df, false))
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
            push!(plots, plotfeature(feature, df))
        end
    end

    plt = plot(plots..., layout=length(plots))

    if isnothing(path)
        display(plt)
    else
        savefig(plt, path)
    end
end


function visualize(
    rule::Rule,
    dataset::Dataset;
    path::Union{String,Nothing}=nothing,
    allfeatures::Bool=false,
    antecedent::Bool=true,
    consequent::Bool=true,
    timeseries::Bool=false,
    intervalcolumn::String="interval",
    interval::Int64=0
)
    visualize(
        rule,
        dataset.transactions,
        path=path,
        allfeatures=allfeatures,
        antecedent=antecedent,
        consequent=consequent,
        timeseries=timeseries,
        intervalcolumn=intervalcolumn,
        interval=interval
    )
end
