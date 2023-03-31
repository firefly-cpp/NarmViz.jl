function select_feature(df::DataFrame, interval::Int64, feature::String)
    values = @chain df begin
        @rsubset :interval == interval
        @select(cols(feature))
    end
end

function calculate_points(num_items::Int64, position::Int64)
    (1 / num_items) + position
end

function if_antecedent(feature::String, antecedent::Vector{Attribute})
    for ante in antecedent
        if feature == ante.name
            return true, ante.min, ante.max
        end
    end
    return false, false, false
end

function if_consequence(feature::String, consequence::Vector{Attribute})
    for con in consequence
        if feature == con.name
            return true, con.min, con.max
        end
    end
    return false, false, false
end

function calculate_area(
    x1::Union{Int64,Float64},
    x2::Union{Int64,Float64},
    x3::Union{Int64,Float64},
    x4::Union{Int64,Float64},
)
    Shape(x3 .+ [0, x1, x1, 0], x4 .+ [0, 0, x2, x2])
end

function create_plots(
    transactions::Transactions,
    settings::Settings,
    interval::Int64,
    antecedent::Vector{Attribute},
    consequence::Vector{Attribute},
)
    colors = [:red, :blue, :green, :yellow, :navy, :purple, :cyan]
    popfirst!(transactions.features) # TODO: optional
    plots = Any[]
    for i = 1:length(transactions.features)
        Y = Matrix(
            select_feature(transactions.transactions, interval, transactions.features[i]),
        )
        x = Vector{Float64}()
        for y = 1:length(Y)
            append!(x, calculate_points(length(Y), y))
        end
        # check whether this feature is a part of the antecedent or consequence
        check, minval, maxval = if_antecedent(transactions.features[i], antecedent)
        check2, minval2, maxval2 = if_consequence(transactions.features[i], consequence)

        shapes = Dict('a' => :star, 'n' => :circle, 'c' => :hexagon)

        if (check)
            # prepare different shapes for antecedent/consequence element
            markers = Vector{Char}()
            for i = 1:length(Y)
                if Y[i] >= minval && Y[i] <= maxval
                    append!(markers, "a")
                else
                    append!(markers, "n")
                end
            end

            final_shapes = [shapes[src] for src in markers]

            area = plot(
                calculate_area(length(Y), (maxval - minval), 0, minval),
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
                    title = transactions.features[i],
                    titlefontsize = 6,
                    xtickfontsize = 4,
                    xguidefontsize = 4,
                    ytickfontsize = 4,
                    seriestype = :scatter,
                    ylim = [minimum(Y) - 10, maximum(Y) + 10],
                    colour = [colors[rand(1:length(colors))]],
                    markershape = final_shapes,
                    xlabel = "series",
                    legend = false,
                ),
            )

        elseif (check2)
            markers = Vector{Char}()
            for i = 1:length(Y)
                if Y[i] >= minval2 && Y[i] <= maxval2
                    append!(markers, "c")
                else
                    append!(markers, "n")
                end
            end
            final_shapes = [shapes[src] for src in markers]

            area = plot(
                calculate_area(length(Y), (maxval2 - minval2), 0, minval2),
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
                    title = transactions.features[i],
                    titlefontsize = 6,
                    xtickfontsize = 4,
                    xguidefontsize = 4,
                    ytickfontsize = 4,
                    seriestype = :scatter,
                    ylim = [minimum(Y) - 10, maximum(Y) + 10],
                    colour = [colors[rand(1:length(colors))]],
                    markershape = final_shapes,
                    xlabel = "series",
                    legend = false,
                ),
            )

        else
            println("ignore")
            #push!(plots, plot(x, Y, title=features[i], titlefontsize=6, xtickfontsize=4, xguidefontsize=4, ytickfontsize=4, seriestype=:scatter, ylim=calculate_ylim(Y), colour=[colors[rand(1:length(colors))]], xlabel="series", legend=false))
        end
    end
    final_plot = plot(plots..., layout = length(plots))
    savefig(final_plot, settings.output_path)
end
