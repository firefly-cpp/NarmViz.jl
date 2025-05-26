"""
    plotattribute(attribute, transactions, plot_type, isantecedent)

Generates a visualization for a single attribute based on the provided transactions data.

# Arguments
- `attribute::Union{NumericalAttribute,CategoricalAttribute}`: an attribute to visualize
- `transactions::DataFrame`: a data frame containing transaction data
- `plot_type::VizType`: a type of plot to generate (e.g, Scatter, Boxploit, ...)
- `isantecedent::Bool`: a decision if the attribute is part of the antecedent (true) or consequent (false)

# Returns
The plot object with the visualization of the passed attribute data.

# Throws
- `AssertionError`: if an unsupported plot type is specified for the attribute.
"""
function plotattribute(
    attribute::Union{NumericalAttribute,CategoricalAttribute},
    transactions::DataFrame,
    plot_type::VizType,
    isantecedent::Bool
)
    if attribute isa CategoricalAttribute
        return plot_categorical_attribute(attribute, transactions, isantecedent)
    elseif attribute isa NumericalAttribute
        if plot_type == Scatter
            return plot_scatter_num_attribute(attribute, transactions, isantecedent)
        elseif plot_type == Bar
            return plot_bar_num_attribute(attribute, transactions, isantecedent)
        elseif plot_type == Line
            return plot_line_num_attribute(attribute, transactions, isantecedent)
        elseif plot_type == Boxplot
            return plot_boxplot_num_attribute(attribute, transactions, isantecedent)
        end
    end

    @assert false "Unsupported plot type for attribute: $plot_type"
end

"""
    plotfeature(feature, transactions, plot_type)

Generates a visualization for a single feature based on the provided transactions data.

# Arguments
- `feature::Union{NumericalFeature,CategoricalFeature}`: a feature to visualize
- `transactions::DataFrame`: a data frame containing transaction data
- `plot_type::VizType`: a type of plot to generate (e.g, Scatter, Boxploit, ...)

# Returns
The plot object with the visualization of the feature data.

# Throws
- `AssertionError`: if an unsupported plot type is specified for the feature.
"""
function plotfeature(
    feature::Union{NumericalFeature,CategoricalFeature},
    transactions::DataFrame,
    plot_type::VizType
)
    if feature isa CategoricalFeature
        return plot_categorical_feature(feature, transactions)
    elseif feature isa NumericalFeature
        if plot_type == Scatter
            return plot_scatter_num_feature(feature, transactions)
        elseif plot_type == Bar
            return plot_bar_num_feature(feature, transactions)
        elseif plot_type == Line
            return plot_line_num_feature(feature, transactions)
        elseif plot_type == Boxplot
            return plot_boxplot_num_feature(feature, transactions)
        end
    end

    @assert false "Unsupported plot type for feature: $plot_type"
end

"""
    visualize(rule, data; path=nothing, allfeatures=false, antecedent=true, consequent=true,
              timeseries=false, intervalcolumn="interval", interval=0, plot_type="scatter")

Visualizes a rule with respect to the provided dataset or transaction data.

# Arguments
- `rule::Rule`: a rule to visualize
- `data::Union{DataFrame,Dataset}`: a dataset or transaction data frame

# Optional Arguments
- `path::Union{String,Nothing}=nothing`: a path to save the plot (`nothing` displays plot)
- `allfeatures::Bool=false`: if the visualization should include all features not in the rule.
- `antecedent::Bool=true`: if the visualization should include attributes in the rule antecedent
- `consequent::Bool=true`: if the visualization should include attributes in the rule consequent
- `timeseries::Bool=false`: if the dataset should be filtered by time intervals
- `intervalcolumn::String="interval"`: a column name to filter by time intervals
- `interval::Int64=0`: a specific interval to visualize (if `timeseries` is `true`)
- `plot_type::VizType=Scatter`: a type of plot to generate (e.g, Scatter, Boxploit, ...)

# Returns
Displays or saves the generated plot based on the `path` parameter.
"""
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
    plot_type::VizType=Scatter
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
        # Ensure the directory exists before saving the plot
        if !ispath(dirname(path))
            mkpath(dirname(path))
        end
        savefig(plt, path)
    end
end
