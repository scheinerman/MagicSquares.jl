module MagicSquares

using JuMP
using ChooseOptimizer

export magic, magic_fast, magic_check

include("magic_check.jl")
include("ilp_square.jl")
include("magic_odd.jl")
include("double_even.jl")
include("single_even.jl")
include("magic_fast.jl")

end # module MagicSquares
