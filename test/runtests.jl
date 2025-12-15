using MagicSquares, Test

@testset "Basics" begin
    M = magic(4)
    @test magic_check(M)

    M = ones(Int, 5, 5)
    @test !magic_check(M)

    for n in 7:9
        M = magic_fast(n)
        @test magic_check(M)
    end
end
