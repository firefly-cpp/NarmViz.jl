function select_feature(df, interval, feature)
    values = @chain df begin
        @rsubset :interval == interval
        @select(cols(feature))
    end
end

function calculate_points(num_items, position)
    (1 / num_items) + position
end

function calculate_ylim(X)
    [minimum(X), maximum(X)]
end

function create_plots(df, interval)
    colors = [:red, :blue, :green, :yellow, :navy, :purple, :cyan]
    features = names(df)
    popfirst!(features) # TODO: optional
    plots = Any[]
    for i in 1:length(features)
        Y = Matrix(select_feature(dataset, interval, features[i]))
        x = Vector{Float64}()
        for y in 1:length(Y)
            append!(x, calculate_points(length(Y), y))
        end
        push!(plots, plot(x, Y, title=features[i], titlefontsize=6, xtickfontsize=4, ytickfontsize=4, seriestype=:scatter, ylim=calculate_ylim(Y), colour=[colors[rand(1:length(colors))]], legend=false))
    end
    final_plot = plot(plots...,layout=length(plots))
    savefig(final_plot, "viz.pdf")
end
