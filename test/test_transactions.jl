@testset "Transaction database Tests" begin

    transactions = Transactions("test_data/simple-test.csv")

    @test length(transactions.features) == 17
end
