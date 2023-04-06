struct Transactions
    transactions::DataFrame
    features::Vector{String}

    function Transactions(df::DataFrame)

        if nrow(df) < 1
            throw(DomainError("Wrong transaction database"))
        end

        features = getfeaturenames(df)

        new(df, features)
    end

    function Transactions(path::String)
        transactions = CSV.File(path) |> DataFrame
        return Transactions(transactions)
    end
end

function getfeaturenames(df::DataFrame)
    return names(df)
end

function getcolumnvalues(df::DataFrame, column::String)
    return df[:,column]
end
