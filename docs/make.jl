using Documenter
using NarmViz

makedocs(
    sitename = "NarmViz",
    format = Documenter.HTML(
      prettyurls = get(ENV, "CI", nothing) == "true",
      canonical = "https://github.com/firefly-cpp/NarmViz.jl"
    ),
    modules = [NarmViz],
    pages = [
        "Home" => "index.md",
        "Getting Started" => "getting_started.md",
        "API Reference" => "api.md",
        "Examples" => "examples.md",
        "Contributors" => "contributors.md",
        "Contributing" => "contributing.md",
        "License" => "license.md"
    ]
)
