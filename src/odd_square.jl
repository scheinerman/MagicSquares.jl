"""
    odd_magic_square(n::Int)

Create a magic square of *odd* order `n`. 
"""
function odd_magic_square(n::Int)
    @assert n>0 "Magic square size must be positive"
    @assert mod(n, 2)==1 "Magic square size must be odd"

    M = zeros(Int, n, n)

    loc = 1, (n+1)÷2
    for v in 1:(n ^ 2)
        M[loc...] = v

        new_loc = _move_north_east(loc, n)
        if M[new_loc...] == 0
            loc = new_loc
        else
            loc = _move_south(loc, n)
        end
    end

    if !magic_check(M)
        error("Something went wrong")
    end

    return M
end

function _move_north_east(loc::Tuple{Int,Int}, n::Int)::Tuple{Int,Int}
    i, j = loc
    i = mod1(i-1, n)
    j = mod1(j+1, n)
    return i, j
end

function _move_south(loc::Tuple{Int,Int}, n::Int)::Tuple{Int,Int}
    i, j = loc
    i = mod1(i+1, n)
    return i, j
end
