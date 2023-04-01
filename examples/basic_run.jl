using NarmViz

# load transaction database
transactions = Transactions("/home/iztok/julia-plotting/intervali.csv")

# layout setting for visualization
settings = Settings(
    all_features = false, # visualize all features not only antecedents and consequence
    interval = "interval", # name of column which denotes the interval
    antecedents = true, # visualize antecedents
    consequence = true, # visualize consequence
    antecedent_color = :blue, # color for showing antecedent area
    consequence_color = :red, # color for showing consequence area
    title = "My first plot", # title of visualization
    output_path = "visualization.pdf"
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
visualize(transactions, settings, 9, antecedents, consequence)
