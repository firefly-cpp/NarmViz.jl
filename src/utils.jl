rectangle(x, y, w, h) = Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])

randcolor() = rand(palette(:phase, 255)[1:end])

function valuecounts(column)
    counts = Dict{String,Int}()
    for value in column
        counts[value] = get(counts, value, 0) + 1
    end
    return sort(counts)
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
