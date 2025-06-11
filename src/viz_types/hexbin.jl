function hexbin(x, y; bins=5, title="None", kwargs...)
    h = StatsBase.fit(Histogram, (x, y), nbins=bins)

    x_centers = [(h.edges[1][i] + h.edges[1][i+1]) / 2 for i in 1:length(h.edges[1])-1]
    y_centers = [(h.edges[2][j] + h.edges[2][j+1]) / 2 for j in 1:length(h.edges[2])-1]

    plot_x = Float64[]
    plot_y = Float64[]
    plot_counts = Float64[]

    for (i, x_c) in enumerate(x_centers)
        for (j, y_c) in enumerate(y_centers)
            count = h.weights[i, j]
            if count <= 0
                continue
            end

            offset = (j % 2) * (x_centers[2] - x_centers[1]) / 2
            push!(plot_x, x_c + offset)
            push!(plot_y, y_c)
            push!(plot_counts, count)
        end
    end

    scatter(plot_x, plot_y,
        marker=:hexagon,
        markersize=[8 * sqrt(c / maximum(plot_counts)) for c in plot_counts],
        c=plot_counts,
        colorbar=true,
        colorbar_title="Density",
        title=title,
        xlabel="series",
        aspect_ratio=:none,
        xlims=(minimum(x), maximum(x)),
        alpha=0.8;
        kwargs...)
end

function plot_hexbin_num_attribute(attribute::NumericalAttribute, transactions::DataFrame, isantecedent::Bool)
    numitems = nrow(transactions)
    x = 1:numitems
    y = transactions[:, attribute.name]
    linecolour = isantecedent ? :purple : :green

    hex_plot = hexbin(x, y, title="", c=linecolour)

    return plot!(
        hex_plot,
        title=attribute.name,
        titlefontsize=6,
        xtickfontsize=4,
        xguidefontsize=4,
        ytickfontsize=4,
        xlabel="series",
        grid=length(y) < 100,
        legend=false
    )
end

function plot_hexbin_num_feature(feature::NumericalFeature, transactions::DataFrame)
    x = 1:nrow(transactions)
    y = transactions[:, feature.name]

    hex_plot = hexbin(x, y, title="", c=:viridis)

    return plot!(hex_plot,
        title=feature.name,
        titlefontsize=6,
        xtickfontsize=4,
        xguidefontsize=4,
        ytickfontsize=4,
        xlabel="series",
        grid=length(y) < 100,
        color=randcolor(),
        legend=false
    )
end
