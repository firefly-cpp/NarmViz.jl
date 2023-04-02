@testset "Antecedent/Consequent Tests" begin

    antecedents = [
        Attribute("temperature_avg", 11.819, 25.8),
        Attribute("temperature_min", 12.50, 15.0),
        Attribute("moisture_avg", 1771.50, 1985.88),
    ]

    consequence = [
        Attribute("diff_moisture", -167.32, 440.567),
        Attribute("diff_light", 50, 250),
        Attribute("light_min", 100, 300),
    ]

    a, b, c = if_antecedent("temperature_avg", antecedents)
    a1, b1, c1 = if_consequence("temperature_avg", consequence)
    @test length(antecedents) == 3
    @test length(consequence) == 3
    @test a == true
    @test b == 11.819
    @test c == 25.8
    @test a1 == false
    @test b1 == false
    @test c1 == false

end
