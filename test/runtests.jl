using MagicSquares, Test

@testset "Slow test" begin
    for k in 3:5
        M = magic(k)
        @test magic_check(M)
    end
end

@testset "Fast test" begin
    M = ones(Int, 5, 5)
    @test !magic_check(M)

    for n in 3:15
        M = magic_fast(n)
        @test magic_check(M)
    end
end
