using NarmViz
using NiaARM

# load transaction database
dataset = Dataset("datasets/random_sportydatagen.csv")

# vector of antecedents
antecedent = Attribute[
    NumericalAttribute("duration", 50, 65),
    NumericalAttribute("distance", 15.0, 40.0),
]

# vector of consequents
consequent = Attribute[
    NumericalAttribute("calories", 200.0, 450.0),
    NumericalAttribute("descent", 50.0, 140.0),
]

rule = Rule(antecedent, consequent)

# call the visualization function
visualize(
    rule,
    dataset,
    path="barchart.pdf", # path (if not specified, the plot will be displayed in the GUI)
    allfeatures=false, # visualize all features, not only antecedents and consequence
    antecedent=true, # visualize antecedent
    consequent=true, # visualize consequent
    timeseries=true, # set false for non-time series datasets
    intervalcolumn="interval", # Name of the column which denotes the interval (only for time series datasets)
    interval=3, # which interval to visualize
    plot_type=Bar
)
