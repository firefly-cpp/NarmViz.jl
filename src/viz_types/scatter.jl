function plot_scatter_num_attribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
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

function plot_scatter_num_feature(feature::NumericalFeature, transactions::DataFrame)
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
