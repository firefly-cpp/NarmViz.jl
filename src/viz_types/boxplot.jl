function plot_boxplot_num_attribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
    data = transactions[:, attribute.name]
    linecolour = isantecedent ? :purple : :green
    surfacecolor = isantecedent ? :purple : :green


    p = boxplot(
        [attribute.name],
        [data],
        title=attribute.name,
        titlefontsize=6,
        xtickfontsize=4,
        ytickfontsize=4,
        color=linecolour,
        fillcolor=surfacecolor,
        legend=false
    )

    # TODO: highlight min-max range

    return p
end

function plot_boxplot_num_feature(feature::NumericalFeature, transactions::DataFrame)
    data = transactions[:, feature.name]

    return boxplot(
        [feature.name],
        [data],
        title=feature.name,
        titlefontsize=6,
        xtickfontsize=4,
        ytickfontsize=4,
        color=randcolor(),
        legend=false
    )
end
