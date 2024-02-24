@testset "Transaction database Tests" begin

    dataset = Dataset("test_data/simple-test.csv")
    transactions = dataset.transactions
    @test ncol(transactions) == 17

    features = names(transactions)

    @test features[1] == "interval"
    @test features[2] == "temperature_avg"

end
