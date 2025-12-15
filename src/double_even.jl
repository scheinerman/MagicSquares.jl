"""
    double_even_magic_square(n::Int)

Create a magic square of order `n` provided `n` is divisible by 4. 
"""
function double_even_magic_square(n::Int)
    @assert mod(n, 4)==0 "$n is not divisible by 4"
    @assert n>0 "$n is not positive"

    M = _template(n) .* _forward(n) + (1 .- _template(n)) .* _backward(n)

    return M
end

function _template(n::Int)
    T0 = [
        1 0 0 1
        0 1 1 0
        0 1 1 0
        1 0 0 1
    ]
    if n==4
        return T0
    end

    T = zeros(Int, n, n)
    for a in 1:(n ÷ 4)
        for b in 1:(n ÷ 4)
            i = (4a - 3):(4a)
            j = (4b - 3):(4b)
            T[i, j] = T0
        end
    end
    return T
end

function _forward(n::Int)
    vals = collect(1:(n ^ 2))
    return reshape(vals, n, n)
end

function _backward(n::Int)
    vals = collect((n ^ 2):-1:1)
    return reshape(vals, n, n)
end
