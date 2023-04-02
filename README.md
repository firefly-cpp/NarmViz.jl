# NarmViz.jl

## About

NarmViz.jl is a Julia framework for visualization of time series numerical association rules.

## Detailed insights
The current version includes (but is not limited to) the following functions:

- loading datasets in CSV format,
- preprocessing of data,
- visualization of association rules,
- exporting figures to files.

## Visualization examples

Example 1            |  Example 2
:-------------------------:|:-------------------------:
![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig1.png)  |  ![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig2.png)

## Installation

```
pkg> add NarmViz
```

## Usage

### Basic run example

```julia
using NarmViz

# load transaction database
transactions = Transactions("/home/iztok/julia-plotting/intervali.csv")

# basic settings for visualization
settings = Settings(
    all_features = true, # visualize all features not only antecedents and consequence
    interval = "interval", # name of column which denotes the interval
    antecedents = true, # visualize antecedents
    consequence = true, # visualize consequence
    antecedent_color = :blue, # color for showing antecedent area
    consequence_color = :red, # color for showing consequence area
    title = "My first plot", # title of visualization
    output_path = "visualization.pdf" # path
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
```

## Related work:

Ideas are based on the following research papers:

[1] Fister Jr, I., Fister, I., Fister, D., Podgorelec, V., & Salcedo-Sanz, S. (2023). A comprehensive review of visualization methods for association rule mining: Taxonomy, Challenges, Open problems and Future ideas. arXiv preprint arXiv:2302.12594.

[2] Fister Jr, I., Fister, D., Fister, I., Podgorelec, V., & Salcedo-Sanz, S. (2022). Time series numerical association rule mining variants in smart agriculture. arXiv preprint arXiv:2212.03669.

## License

This package is distributed under the MIT License. This license can be found online at <http://www.opensource.org/licenses/MIT>.

## Disclaimer

This framework is provided as-is, and there are no guarantees that it fits your purposes or that it is bug-free. Use it at your own risk!
