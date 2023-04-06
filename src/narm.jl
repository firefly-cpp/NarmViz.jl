"""
Implement a simple query that filters
the data corresponding to the selected interval.
"""
function select_feature(df::DataFrame, interval::Int64, feature::String)
    values = @chain df begin
        @rsubset :interval == interval
        @select(cols(feature))
    end
end

"""
Calculate the position for placing
time series data on the x-axis.
"""
function calculate_points(num_items::Int64, position::Int64)
    (1 / num_items) + position
end

"""
Calculate the position for placing time series data on the x-axis.
"""
function calculate_area(
    x1::Union{Int64,Float64},
    x2::Union{Int64,Float64},
    x3::Union{Int64,Float64},
    x4::Union{Int64,Float64},
)
    Shape(x3 .+ [0, x1, x1, 0], x4 .+ [0, 0, x2, x2])
end

function calculate_x_y(transactions::DataFrame, interval::Int64, feature::String)
    Y = Matrix(select_feature(transactions, interval, feature))
    x = Vector{Float64}()
    for y = 1:length(Y)
        append!(x, calculate_points(length(Y), y))
    end
    return Y, x
end

function get_shapes(Y::Matrix, rule::String, min::Float64, max::Float64)
    # provide symbols for time series data points
    # a is antecedent, n is a point not belonging to antecedent or consequence, c is a consequence
    shapes = Dict('a' => :star, 'n' => :circle, 'c' => :hexagon)

    markers = Vector{Char}()
    for i = 1:length(Y)
        if Y[i] >= min && Y[i] <= max && rule == "antecedent"
            append!(markers, "a")
        elseif Y[i] >= min && Y[i] <= max && rule == "consequence"
            append!(markers, "c")
        else
            append!(markers, "n")
        end
    end
    return [shapes[src] for src in markers]
end

"""
Implement a central function for the visualization of plots.
"""
function create_plots(
    transactions::Transactions,
    settings::Settings,
    interval::Int64,
    antecedent::Vector{Attribute},
    consequence::Vector{Attribute},
)
    # list of selected colors
    colors = [:red, :blue, :green, :yellow, :navy, :purple, :cyan]

    # remove a column where the interval value appears. It is only essential when visualizing all features.
    deleteat!(
        transactions.features,
        findall(x -> x == settings.interval, transactions.features),
    )
    # store plots
    plots = Any[]

    # plot antecedents first
    if settings.antecedents
        for ant in antecedent
            feature = ant.name
            Y, x = calculate_x_y(transactions.transactions, interval, feature)

            final_shapes = get_shapes(Y, "antecedent", ant.min, ant.max)

            area = plot(
                calculate_area(length(Y) + 1, (ant.max - ant.min), 0, ant.min),
                opacity = 0.5,
                fill = settings.antecedent_color,
                aspect = :equal,
            )
            push!(
                plots,
                plot(
                    area,
                    x,
                    Y,
                    title = feature,
                    titlefontsize = 6,
                    xtickfontsize = 4,
                    xguidefontsize = 4,
                    ytickfontsize = 4,
                    xticks = 0:2:length(transactions.features),
                    seriestype = :scatter,
                    xlim = [0, length(transactions.features) + 1],
                    ylim = [minimum(Y) - 10, maximum(Y) + 10],
                    colour = :purple,
                    markershape = final_shapes,
                    xlabel = "series",
                    legend = false,
                ),
            )
        end
    end

    # plot consequence
    if settings.consequence
        for con in consequence
            feature = con.name
            Y, x = calculate_x_y(transactions.transactions, interval, feature)

            final_shapes = get_shapes(Y, "consequence", con.min, con.max)

            area = plot(
                calculate_area(length(Y) + 1, (con.max - con.min), 0, con.min),
                opacity = 0.5,
                fill = settings.consequence_color,
                aspect = :equal,
            )
            push!(
                plots,
                plot(
                    area,
                    x,
                    Y,
                    title = feature,
                    titlefontsize = 6,
                    xtickfontsize = 4,
                    xguidefontsize = 4,
                    ytickfontsize = 4,
                    xticks = 0:2:length(transactions.features),
                    seriestype = :scatter,
                    xlim = [0, length(transactions.features) + 1],
                    ylim = [minimum(Y) - 10, maximum(Y) + 10],
                    colour = :green,
                    markershape = final_shapes,
                    xlabel = "series",
                    legend = false,
                ),
            )

        end
    end

    # visualize remaining features
    if settings.all_features == true
        for ant in antecedent
            deleteat!(
                transactions.features,
                findall(x -> x == ant.name, transactions.features),
            )
        end

        for con in consequence
            deleteat!(
                transactions.features,
                findall(x -> x == con.name, transactions.features),
            )
        end
        for i = 1:length(transactions.features)

            Y, x =
                calculate_x_y(transactions.transactions, interval, transactions.features[i])

            final_shapes = get_shapes(Y, "plain", 0.0, 0.0)

            push!(
                plots,
                plot(
                    x,
                    Y,
                    title = transactions.features[i],
                    titlefontsize = 6,
                    xtickfontsize = 4,
                    xguidefontsize = 4,
                    ytickfontsize = 4,
                    xticks = 0:2:length(transactions.features),
                    seriestype = :scatter,
                    xlim = [0, length(transactions.features) + 1],
                    ylim = [minimum(Y) - 10, maximum(Y) + 10],
                    colour = [colors[rand(1:length(colors))]],
                    xlabel = "series",
                    legend = false,
                ),
            )
        end
    end


    final_plot = plot(plots..., layout = length(plots))
    savefig(final_plot, settings.output_path)
end
