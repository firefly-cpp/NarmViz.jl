@testset "Transaction database Tests" begin

    transactions = load_transactions("test_data/simple-test.csv")

    @test ncol(transactions) == 17

    features = names(transactions)

    @test features[1] == "interval"
    @test features[2] == "temperature_avg"

end
