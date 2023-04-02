@testset "Transaction database Tests" begin

    transactions = Transactions("test_data/simple-test.csv")
    features = transactions.features

    @test length(features) == 17

    @test features[1] == "interval"
    @test features[2] == "temperature_avg"

end
