function plot_violin_num_attribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
    data = transactions[:, attribute.name]
    linecolour = isantecedent ? :purple : :green
    surfacecolor = isantecedent ? :blue : :red


    p = violin(
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

    # highlight min-max range
    # Todo

    return p
end

function plot_violin_num_feature(feature::NumericalFeature, transactions::DataFrame)
    data = transactions[:, feature.name]

    return violin(
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
