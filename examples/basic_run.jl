using NarmViz

# load transaction database
transactions = Transactions("/home/iztok/julia-plotting/intervali.csv")

# layout setting for visualization
layout = Layout(
    features = ["feat1", "feat2"],
    antecedents = true,
    consequence = true,
    title = "My first plot",
)

# vector of antecedents
antecedents = [
    Attribute("temperature_avg", 11.819, 25.8),
    Attribute("temperature_min", 12.50, 15.0),
    Attribute("moisture_avg", 1771.50, 1985.88),
]

# vector of consequents
consequence = [
    Attribute("diff_moisture", -167.32, 440.567),
    Attribute("diff_light", 50, 250),
    Attribute("light_min", 100, 300),
]

# call main function for visualization
visualize(transactions, layout, 9, antecedents, consequence)
