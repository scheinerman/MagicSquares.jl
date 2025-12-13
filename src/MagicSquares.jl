module MagicSquares

using JuMP
using ChooseOptimizer

export magic, magic_check

"""
    magic(n::Int)

Create a magic square of order `n` using integer linear programming. Throws an error
if no such magic square exists. 
"""
function magic(n::Int)::Matrix{Int}
    @assert n>0 "Magic square size must be positive."

    MOD = Model(get_solver())
    m = n * (n^2 + 1) ÷ 2

    @variable(MOD, x[1:n, 1:n, 1:(n ^ 2)], Bin)

    # The value k appears in at most one cell
    for k in 1:(n ^ 2)
        @constraint(MOD, sum(x[i, j, k] for i in 1:n for j in 1:n) == 1)
    end

    # The value k cannot appear in more than one cell
    for i in 1:n
        for j in 1:n
            @constraint(MOD, sum(x[i, j, k] for k in 1:(n ^ 2)) == 1)
        end
    end

    # Row sums equal m 
    for i in 1:n
        @constraint(MOD, sum(k*x[i, j, k] for j in 1:n for k in 1:(n ^ 2)) == m)
    end

    # Column sums equal m 
    for j in 1:n
        @constraint(MOD, sum(k*x[i, j, k] for i in 1:n for k in 1:(n ^ 2)) == m)
    end

    # Diagonal sums equal m 
    @constraint(MOD, sum(k*x[i, i, k] for i in 1:n for k in 1:(n ^ 2))==m)
    @constraint(MOD, sum(k*x[i, n + 1 - i, k] for i in 1:n for k in 1:(n ^ 2))==m)

    optimize!(MOD)
    t = Int(termination_status(MOD))

    if Int(t) ≠ 1
        error("No magic square of order $n exists")
    end

    X = Int.(round.(value.(x)))

    M = zeros(Int, n, n)
    for i in 1:n
        for j in 1:n
            for k in 1:(n * n)
                if X[i, j, k] == 1
                    M[i, j] = k
                end
            end
        end
    end

    return M
end

"""
    magic_check(M::Matrix{Int})::Bool

Check if `M` is a magic square.
"""
function magic_check(M::AbstractMatrix{Int})::Bool
    n, c = size(M)
    if n≠c
        return false
    end

    m = n*(n^2+1)÷2

    s = sum(M; dims=1)

    if !(_vec_value_check(s, m))
        return false
    end

    s = sum(M; dims=2)
    if !(_vec_value_check(s, m))
        return false
    end

    s = sum(M[i, i] for i in 1:n)  # diagonal sum 
    if s ≠ m
        return false
    end

    s = sum(M[i, n + 1 - i] for i in 1:n)  # antidiagonal sum 
    if s ≠ m
        return false
    end

    return true
end

"""
    _vec_value_check(vec, val)::Bool

Check that all elements of `vec` are equal to `val`.
"""
_vec_value_check(vec, val)::Bool = all(vec .== val)

end # module MagicSquares
