export single_even_magic

function single_even_magic(n::Int)
    @assert mod(n, 4)==2 "mod($n,4) ≠ 2"
    @assert n>2 "No magic square of size $n"
    LUX = make_LUX(n)
end

function make_LUX(n::Int)
    m = (n-2)÷4  # so n = 4m+2

    L = 1
    U = 2
    X = 3

    LUX = zeros(Int, n÷2, n÷2)

    for i in 1:(n ÷ 2)
        if i <= m+1
            LUX[i, :] .= L
        elseif i==m+2
            LUX[i, :] .= U
        else
            LUX[i, :] .= X
        end
    end

    LUX[m + 1, m + 1], LUX[m + 2, m + 1] = LUX[m + 2, m + 1], LUX[m + 1, m + 1]

    return LUX
end

"""
    Source material https://mathworld.wolfram.com/MagicSquare.html 
"""

"""
    M6()

This is wrong :-(
"""
function M6()
    M = [
        32 29 4 1 24 21
        30 31 2 3 22 23
        12 9 17 19 28 25
        10 11 18 20 26 27
        13 15 36 33 5 8
        14 16 34 35 6 7
    ]
end
