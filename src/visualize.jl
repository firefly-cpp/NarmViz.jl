rectangle(x, y, w, h) = Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])

randcolor() = rand(keys(Colors.color_names))

function markers(values, min, max, isantecedent)
    shapes = Vector{Symbol}(undef, length(values))
    for i in eachindex(values)
        if min <= values[i] <= max
            shapes[i] = isantecedent ? :star : :hexagon
        else
            shapes[i] = :circle
        end
    end
    return shapes
end

function plotattribute(attribute, transactions, isantecedent)
    numitems = nrow(transactions)
    x = 1:numitems
    y = transactions[:, attribute.name]
    markershape = markers(y, attribute.min, attribute.max, true)
    linecolour = isantecedent ? :purple : :green
    surfacecolor = isantecedent ? :blue : :red

    area = plot(
        rectangle(0, attribute.min, numitems, attribute.max - attribute.min),
        opacity=0.5,
        fill=surfacecolor,
        aspect=:equal
    )

    return plot(
        area,
        x,
        y,
        title=attribute.name,
        titlefontsize=6,
        xtickfontsize=4,
        xguidefontsize=4,
        ytickfontsize=4,
        seriestype=:scatter,
        xlim=[0, numitems],
        ylim=[minimum(y) - 10, maximum(y) + 10],
        colour=linecolour,
        markershape=markershape,
        xlabel="series",
        legend=false,
        grid=length(y) < 100,
    )
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
    if timeseries
        subset!(transactions, intervalcolumn => i -> i .== interval)
    end

    select!(transactions, Not([intervalcolumn]))

    plots = []

    if antecedent
        for attribute in rule.antecedent
            push!(plots, plotattribute(attribute, transactions, true))
        end
    end

    if consequent
        for attribute in rule.consequent
            push!(plots, plotattribute(attribute, transactions, false))
        end
    end

    if allfeatures
        if antecedent
            select!(transactions, Not([attr.name for attr in rule.antecedent]))
        end

        if consequent
            select!(transactions, Not([attr.name for attr in rule.consequent]))
        end

        for feature in names(transactions)
            x = 1:nrow(transactions)
            y = transactions[:, feature]
            push!(plots, plot(
                x,
                y,
                title=feature,
                titlefontsize=6,
                xtickfontsize=4,
                xguidefontsize=4,
                ytickfontsize=4,
                seriestype=:scatter,
                xlim=[0, nrow(transactions)],
                ylim=[minimum(y) - 10, maximum(y) + 10],
                colour=randcolor(),
                markershape=:circle,
                xlabel="series",
                legend=false,
                grid=length(y) < 100
            ))
        end
    end

    plt = plot(plots..., layout=length(plots))

    if isnothing(path)
        display(plt)
    else
        savefig(plt, path)
    end
end
