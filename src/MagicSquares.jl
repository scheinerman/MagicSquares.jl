module MagicSquares

using JuMP
using ChooseOptimizer

export magic, magic_check, odd_magic_square

include("magic_check.jl")
include("ilp_square.jl")
include("odd_square.jl")

end # module MagicSquares
