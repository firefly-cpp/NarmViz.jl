using NarmViz

# load transaction database
transactions = Transactions("datasets/random_sportydatagen.csv")

# basic settings for visualization
settings = Settings(
    all_features = false, # visualize all features, not only antecedents and consequence
    timeseries = false, # set false for non-time series datasets
    interval = "interval", # Name of the column which denotes the interval (only for time series datasets)
    antecedents = true, # visualize antecedents
    consequence = true, # visualize consequence
    antecedent_color = :blue, # color for showing the antecedent area
    consequence_color = :red, # color for showing consequence area
    title = "My first plot", # Title of visualization
    output_path = "visualization.pdf" # path
)

# vector of antecedents
antecedents = [
    Attribute("duration", 50, 65),
    Attribute("distance", 15, 40),
]

# vector of consequents
consequence = [
    Attribute("calories", 200, 450),
    Attribute("descent", 50, 140),
]

# call the primary function for visualization
# 3 denotes the interval; see the test dataset for an example
visualize(transactions, settings, 3, antecedents, consequence)

# use the following function call when dealing with non-time series data
# visualize(transactions, settings, antecedents, consequence)
