using NarmViz

# load transaction database
transactions = load_transactions("datasets/random_sportydatagen.csv")

# vector of antecedents
antecedent = [
    Attribute("duration", 50, 65),
    Attribute("distance", 15, 40),
]

# vector of consequents
consequent = [
    Attribute("calories", 200, 450),
    Attribute("descent", 50, 140),
]

rule = Rule(antecedent, consequent)

# call the visualization function
visualize(
    rule,
    transactions,
    path="example.pdf", # path (if not specified, the plot will be displayed in the GUI)
    allfeatures=true, # visualize all features, not only antecedents and consequence
    antecedent=true, # visualize antecedent
    consequent=true, # visualize consequent
    timeseries=true, # set false for non-time series datasets
    intervalcolumn="interval", # Name of the column which denotes the interval (only for time series datasets)
    interval=3 # which interval to visualize
)

# use the following function call when dealing with non-time series data
# visualize(rule, transactions, path="example.pdf")
