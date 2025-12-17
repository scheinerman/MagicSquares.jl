module MagicSquares

using JuMP
using ChooseOptimizer

export double_even_magic_square, magic, magic_fast, magic_check, odd_magic_square

include("magic_check.jl")
include("ilp_square.jl")
include("odd_square.jl")
include("double_even.jl")
include("single_even.jl")
include("magic_fast.jl")

end # module MagicSquares
