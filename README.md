# NarmViz.jl
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![GitHub license](https://img.shields.io/github/license/firefly-cpp/NarmViz.jl.svg)](https://github.com/firefly-cpp/NarmViz.jl/blob/master/LICENSE)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/firefly-cpp/NarmViz.jl.svg)
![GitHub contributors](https://img.shields.io/github/contributors/firefly-cpp/NarmViz.jl.svg)

## About

NarmViz.jl is a Julia framework primarily developed to visualize time series numerical association rules.
Framework also supports the visualization of the other numerical association rules.

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
```

## References

Ideas are based on the following research papers:

[1] Fister Jr, I., Fister, I., Fister, D., Podgorelec, V., & Salcedo-Sanz, S. (2023). [A comprehensive review of visualization methods for association rule mining: Taxonomy, Challenges, Open problems and Future ideas](https://arxiv.org/abs/2302.12594). arXiv preprint arXiv:2302.12594.

[2] Fister Jr, I., Fister, D., Fister, I., Podgorelec, V., & Salcedo-Sanz, S. (2022). [Time series numerical association rule mining variants in smart agriculture](https://arxiv.org/abs/2212.03669). arXiv preprint arXiv:2212.03669.

[3] I. Fister Jr., I. Fister [A brief overview of swarm intelligence-based algorithms for numerical association rule mining](https://arxiv.org/abs/2010.15524). arXiv preprint arXiv:2010.15524 (2020).

[4] I. Fister Jr., A. Iglesias, A. Gálvez, J. Del Ser, E. Osaba, I Fister. [Differential evolution for association rule mining using categorical and numerical attributes](http://www.iztok-jr-fister.eu/static/publications/231.pdf) In: Intelligent data engineering and automated learning - IDEAL 2018, pp. 79-88, 2018.

## Related software

[NiaARM.jl](https://github.com/firefly-cpp/NiaARM.jl)

## Cite us

 Fister, I. Jr, Fister, I., Podgorelec, V., Salcedo-Sanz, S., & Holzinger, A. (2024). NarmViz: A novel method for visualization of time series numerical association rules for smart agriculture. Expert Systems, 41(3), e13503. [https://doi.org/10.1111/exsy.13503](https://doi.org/10.1111/exsy.13503)

## License

This package is distributed under the MIT License. This license can be found online at <http://www.opensource.org/licenses/MIT>.

## Disclaimer

This framework is provided as-is, and there are no guarantees that it fits your purposes or that it is bug-free. Use it at your own risk!

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://www.iztok-jr-fister.eu/"><img src="https://avatars.githubusercontent.com/u/1633361?v=4?s=100" width="100px;" alt="Iztok Fister Jr."/><br /><sub><b>Iztok Fister Jr.</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Code">💻</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Documentation">📖</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Tests">⚠️</a> <a href="#ideas-firefly-cpp" title="Ideas, Planning, & Feedback">🤔</a> <a href="#mentoring-firefly-cpp" title="Mentoring">🧑‍🏫</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
