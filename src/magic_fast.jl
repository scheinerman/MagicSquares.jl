"""
    magic_fast(n::Int)

Construct a magic square of order `n` using standard methods. Throws an error
if no such magic square exists. 
"""
function magic_fast(n::Int)
    @assert n>0 "$n must be positive"

    if mod(n, 2) == 1
        return odd_magic_square(n)
    end

    if mod(n, 4) == 0
        return double_even_magic_square(n)
    end

    return single_even_magic(n)
end
