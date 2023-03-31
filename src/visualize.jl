function visualize(
    transactions::Transactions,
    settings::Settings,
    interval::Int64,
    antecedents::Vector{Attribute},
    consequence::Vector{Attribute},
    kwargs...,
)
    create_plots(transactions, settings, interval, antecedents, consequence)
    println("Visualization done!")
end
