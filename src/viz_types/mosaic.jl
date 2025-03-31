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

function plot_categorical_attribute(attribute::CategoricalAttribute, transactions::DataFrame, isantecedent::Bool)
    data = valuecounts(transactions[:, attribute.name])
    attributecolor = isantecedent ? :blue : :red
    colors = Dict(category => category == attribute.category ? attributecolor : :grey for category in keys(data))
    plt = mosaic(data, colors=colors)
    title!(plt, attribute.name, titlefontsize=6)
    return plt
end

function plot_categorical_feature(feature::CategoricalFeature, transactions::DataFrame)
    data = valuecounts(transactions[:, feature.name])
    plt = mosaic(data)
    title!(plt, feature.name, titlefontsize=6)
    return plt
end
