function visualize(transactions::Transactions, layout::Layout, interval::Int64, antecedents::Vector{Attribute}, consequence::Vector{Attribute}, kwargs...)
    create_plots(transactions, interval, antecedents, consequence)
    println("Visualization done!")
end

