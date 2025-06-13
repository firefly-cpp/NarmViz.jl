<h1 align="center">
  NarmViz.jl
</h1>

<p align="center">
  <a href="https://juliahub.com/ui/Packages/General/NarmViz">
    <img alt="Version" src="https://juliahub.com/docs/General/NarmViz/stable/version.svg" />
  </a>
  <a href="https://github.com/firefly-cpp/NarmViz.jl/blob/master/LICENSE">
    <img alt="GitHub license" src="https://img.shields.io/github/license/firefly-cpp/NarmViz.jl.svg" />
  </a>
</p>

<p align="center">
  <img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/w/firefly-cpp/NarmViz.jl.svg" />
  <img alt="Average time to resolve an issue" src="http://isitmaintained.com/badge/resolution/firefly-cpp/NarmViz.jl.svg" href="https://isitmaintained.com/project/firefly-cpp/NarmViz.jl">
  <img alt="Percentage of issues still open" src="http://isitmaintained.com/badge/open/firefly-cpp/NarmViz.jl.svg" href="https://isitmaintained.com/project/firefly-cpp/NarmViz.jl">
  <a href="#-contributors">
    <img alt="All Contributors" src="https://img.shields.io/badge/all_contributors-2-orange.svg" />
  </a>
</p>

<p align="center">
  <a href="#-detailed-insights">✨ Detailed insights</a> •
  <a href="#-visualization-examples">📊 Visualization examples</a> •
  <a href="#-installation">📦 Installation</a> •
  <a href="#-usage">🚀 Usage</a> •
  <a href="#-references">📚 References</a> •
  <a href="#-related-software">🔗 Related software</a> •
  <a href="#-cite-us">📄 Cite us</a> •
  <a href="#-license">🔑 License</a> •
  <a href="#-contributors">🫂 Contributors</a>
</p>

NarmViz.jl is a Julia framework primarily developed to visualize time series numerical association rules. 📈 The framework also supports visualization of other numerical association rules.

## ✨ Detailed insights
The current version includes (but is not limited to) the following functions:
- loading datasets in CSV format 📁
- preprocessing of data 🔄
- visualization of association rules 📊
- exporting figures to files 💾

## 📦 Installation

### Julia
To install Julia, follow the instructions on the [official Julia website](https://julialang.org/install/).
Make sure to download the version compatible with your operating system.

### NarmViz.jl
To install NarmViz.jl, open the Julia REPL, type `]` to enter the package manager, and run the following command:
```julia
pkg> add NarmViz
```
This will install the latest version of NarmViz.jl and its dependencies.

### Basic Usage
To use NarmViz.jl, you need to import the package in your Julia script or REPL:
```julia
using NarmViz
```
Now you are ready to start visualizing your data with NarmViz.jl!
For further information on how to use the package, check out the [API Reference](api.md) and [Examples](examples.md) sections.

## 🚀 Examples

This section provides a basic example of how to use NarmViz.jl to visualize numerical association rules as a scatter plot.
If you want to get more insights into the package, check out the [other examples](examples/) and the in depth documentation.

### Basic usage

```julia
using NarmViz
using NiaARM

# load transaction database
dataset = Dataset(joinpath(@__DIR__, "..", "datasets", "random_sportydatagen.csv"))

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
    path=joinpath("build", "scatter.pdf"), # path (if not specified, the plot will be displayed in the GUI)
    allfeatures=false, # visualize all features, not only antecedents and consequence
    antecedent=true, # visualize antecedent
    consequent=true, # visualize consequent
    timeseries=true, # set false for non-time series datasets
    intervalcolumn="interval", # Name of the column which denotes the interval (only for time series datasets)
    interval=3, # which interval to visualize
    plot_type=Scatter
)

```

## 📊 Visualization examples

|                                          Example 1                                          |                                          Example 2                                          |
|:-------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------:|
| ![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig1.png) | ![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig2.png) |

|                                          Example 3                                          |                                          Example 4                                          |
|:-------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------:|
| ![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig3.png) | ![](https://raw.githubusercontent.com/firefly-cpp/NarmViz.jl/main/.github/figures/Fig4.png) |

## 📚 References

Ideas are based on the following research papers:

[1] Fister Jr, I., Fister, I., Fister, D., Podgorelec, V., & Salcedo-Sanz, S. (2023). [A comprehensive review of visualization methods for association rule mining: Taxonomy, Challenges, Open problems and Future ideas](https://arxiv.org/abs/2302.12594). arXiv preprint arXiv:2302.12594.

[2] Fister Jr, I., Fister, D., Fister, I., Podgorelec, V., & Salcedo-Sanz, S. (2022). [Time series numerical association rule mining variants in smart agriculture](https://arxiv.org/abs/2212.03669). arXiv preprint arXiv:2212.03669.

[3] I. Fister Jr., I. Fister [A brief overview of swarm intelligence-based algorithms for numerical association rule mining](https://arxiv.org/abs/2010.15524). arXiv preprint arXiv:2010.15524 (2020).

[4] I. Fister Jr., A. Iglesias, A. Gálvez, J. Del Ser, E. Osaba, I Fister. [Differential evolution for association rule mining using categorical and numerical attributes](http://www.iztok-jr-fister.eu/static/publications/231.pdf) In: Intelligent data engineering and automated learning - IDEAL 2018, pp. 79-88, 2018.

## 🔗 Related software

[NiaARM.jl](https://github.com/firefly-cpp/NiaARM.jl)

## 📄 Cite us

Fister, I. Jr, Fister, I., Podgorelec, V., Salcedo-Sanz, S., & Holzinger, A. (2024). NarmViz: A novel method for visualization of time series numerical association rules for smart agriculture. Expert Systems, 41(3), e13503. [https://doi.org/10.1111/exsy.13503](https://doi.org/10.1111/exsy.13503)

## 🔑 License

This package is distributed under the [MIT License](LICENSE). This license can be found online at <http://www.opensource.org/licenses/MIT>.

## Disclaimer

This framework is provided as-is, and there are no guarantees that it fits your purposes or that it is bug-free. Use it at your own risk!

## 🫂 Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://www.iztok-jr-fister.eu/"><img src="https://avatars.githubusercontent.com/u/1633361?v=4?s=100" width="100px;" alt="Iztok Fister Jr."/><br /><sub><b>Iztok Fister Jr.</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Code">💻</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Documentation">📖</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=firefly-cpp" title="Tests">⚠️</a> <a href="#ideas-firefly-cpp" title="Ideas, Planning, & Feedback">🤔</a> <a href="#mentoring-firefly-cpp" title="Mentoring">🧑‍🏫</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/zStupan"><img src="https://avatars.githubusercontent.com/u/48752988?v=4?s=100" width="100px;" alt="zStupan"/><br /><sub><b>zStupan</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=zStupan" title="Code">💻</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/issues?q=author%3AzStupan" title="Bug reports">🐛</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=zStupan" title="Tests">⚠️</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/lahovniktadej"><img src="https://avatars.githubusercontent.com/u/57890734?v=4?s=100" width="100px;" alt="Tadej Lahovnik"/><br /><sub><b>Tadej Lahovnik</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=lahovniktadej" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.gugacs.me"><img src="https://avatars.githubusercontent.com/u/54801620?v=4?s=100" width="100px;" alt="Marcus Gugacs"/><br /><sub><b>Marcus Gugacs</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=IImpaq" title="Code">💻</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=IImpaq" title="Documentation">📖</a> <a href="#ideas-IImpaq" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=IImpaq" title="Tests">⚠️</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/evaharing"><img src="https://avatars.githubusercontent.com/u/97450071?v=4?s=100" width="100px;" alt="Eva Christina Haring"/><br /><sub><b>Eva Christina Haring</b></sub></a><br /><a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=evaharing" title="Code">💻</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=evaharing" title="Documentation">📖</a> <a href="#ideas-evaharing" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/firefly-cpp/NarmViz.jl/commits?author=evaharing" title="Tests">⚠️</a></td>
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
