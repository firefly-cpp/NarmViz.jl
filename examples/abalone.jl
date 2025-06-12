using NiaARM
using NarmViz

dataset = Dataset(joinpath(@__DIR__, "..", "datasets", "Abalone.csv"))

antecedent = Attribute[
    NumericalAttribute("Rings", 5, 19),
]

consequent = Attribute[
    CategoricalAttribute("Sex", "M")
]

rule = Rule(antecedent, consequent)

visualize(rule, dataset, path="abalone.png")

visualize(rule, dataset, path="abalone_all.png", allfeatures=true, antecedent=false, consequent=false)
