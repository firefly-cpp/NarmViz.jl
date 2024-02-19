function load_transactions(path::String)
    return CSV.read(path, DataFrame)
end
