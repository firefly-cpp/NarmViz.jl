# Examples
The following examples demonstrate how to use NarmViz.jl for visualizing (time series) numerical association rules.
There are several examples available, each showcasing different visualization techniques and features of the package.
The examples are provided in Julia code blocks, you either copy them from here or take a look at the [examples folder](https://github.com/firefly-cpp/NarmViz.jl/tree/main/examples) to run them in your Julia environment.

## Scatterplot
### Code
```@example
using Markdown # hide
code = read("../../examples/scatter_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "scatter_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="scatter.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="scatter.pdf">(download instead)</a></p>
    </object>
```

## Barchart
### Code
```@example
using Markdown # hide
code = read("../../examples/barchart_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "barchart_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="barchart.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="barchart.pdf">(download instead)</a></p>
    </object>
```

## Boxplot
### Code
```@example
using Markdown # hide
code = read("../../examples/boxplot_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "boxplot_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="boxplot.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="boxplot.pdf">(download instead)</a></p>
    </object>
```

## Violin
### Code
```@example
using Markdown # hide
code = read("../../examples/violin_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "violin_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="violin.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="violin.pdf">(download instead)</a></p>
    </object>
```

## Linechart
### Code
```@example
using Markdown # hide
code = read("../../examples/linechart_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "linechart_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="linechart.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="linechart.pdf">(download instead)</a></p>
    </object>
```

## Hexbin Plot
### Code
```@example
using Markdown # hide
code = read("../../examples/hexbin_run.jl", String) # hide
Markdown.parse("```julia\n$(code)\n```") # hide
```

### Output
```@example
path = joinpath(@__DIR__, "..", "..", "examples", "hexbin_run.jl") # hide
@async run(`$(Base.julia_cmd()) $(Base.shell_escape(path))`, wait=false) # hide
nothing # hide
```

```@raw html
    <object data="hexbin.pdf" type="application/pdf" width="100%" height="600px">
        <p>Your browser does not seem to support PDFs. <a href="hexbin.pdf">(download instead)</a></p>
    </object>
```
