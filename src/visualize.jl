rectangle(x, y, w, h) = Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])

randcolor() = rand(palette(:phase, 255)[1:end])

function valuecounts(column)
    counts = Dict{String,Int}()
    for value in column
        counts[value] = get(counts, value, 0) + 1
    end
    return sort(counts)
end

function mosaic(data; colors=nothing, gap=0.005)
    colors = isnothing(colors) ? Dict() : colors
    labels = collect(keys(data))
    counts = collect(values(data))

    proportions = [0; cumsum(counts)]
    proportions = float(proportions) ./ proportions[end]

    xcoords = proportions[1:end-1]
    widths = proportions[2:end] .- xcoords
    xcoords += gap .* range(0, length(proportions) - 2)
    fullwidth = xcoords[end] + widths[end] - xcoords[1]
    xcoords /= fullwidth
    widths /= fullwidth

    rectangles = [(x, 0, w, 1) for (x, w) in zip(xcoords, widths)]
    p = plot(xlim=(0, 1), ylim=(0, 1), legend=false, grid=false, xticks=false, yticks=false)
    for (label, rect) in zip(labels, rectangles)
        x, y, w, h = rect
        shape = rectangle(x, y, w, h)
        color = get(colors, label, :match)
        plot!(p, shape, linecolor=nothing, fillcolor=color)
        annotate!(x + w / 2, y + h / 2, text(label, 10, :center))
    end
    return p
end

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

function plotattribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
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
        colour=linecolour,
        markershape=markershape,
        markersize=2,
        xlabel="series",
        legend=false,
        grid=length(y) < 100,
    )
end

function plotattribute(attribute::CategoricalAttribute, transactions::DataFrame, isantecedent::Bool)
    data = valuecounts(transactions[:, attribute.name])
    attributecolor = isantecedent ? :blue : :red
    colors = Dict(category => category == attribute.category ? attributecolor : :grey for category in keys(data))
    plt = mosaic(data, colors=colors)
    title!(plt, attribute.name, titlefontsize=6)
    return plt
end

function plotfeature(feature::NumericalFeature, transactions::DataFrame)
    x = 1:nrow(transactions)
    y = transactions[:, feature.name]
    return plot(
        x,
        y,
        title=feature.name,
        titlefontsize=6,
        xtickfontsize=4,
        xguidefontsize=4,
        ytickfontsize=4,
        seriestype=:scatter,
        markershape=:circle,
        markersize=2,
        color=randcolor(),
        xlabel="series",
        legend=false,
        grid=length(y) < 100
    )

end

function plotfeature(feature::CategoricalFeature, transactions::DataFrame)
    data = valuecounts(transactions[:, feature.name])
    plt = mosaic(data)
    title!(plt, feature.name, titlefontsize=6)
    return plt
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
