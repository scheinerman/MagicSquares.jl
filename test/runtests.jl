using MagicSquares, Test

M = magic(4)
@test magic_check(M)

M = odd_magic_square(5)
@test magic_check(M)

M = odd_magic_square(11)
@test magic_check(M)

M = ones(Int,5,5)
@test !magic_check(M)