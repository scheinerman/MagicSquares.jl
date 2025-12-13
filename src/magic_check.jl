
"""
    magic_check(M::Matrix{Int})::Bool

Check if `M` is a magic square.
"""
function magic_check(M::AbstractMatrix{Int})::Bool
    n, c = size(M)

    # check that its a square matrix
    if n≠c
        return false
    end

    # check the entries are 1 through n^2 
    entries = sort(collect(M[:]))
    if entries ≠ collect(1:(n ^ 2))
        return false
    end

    # magic number
    m = n*(n^2+1)÷2

    # check row and column sums
    s = sum(M; dims=1)
    if !(_vec_value_check(s, m))
        return false
    end

    s = sum(M; dims=2)
    if !(_vec_value_check(s, m))
        return false
    end

    # check diagonal sums 
    s = sum(M[i, i] for i in 1:n)
    if s ≠ m
        return false
    end

    s = sum(M[i, n + 1 - i] for i in 1:n)
    if s ≠ m
        return false
    end

    # no problems found
    return true
end

"""
    _vec_value_check(vec, val)::Bool

Check that all elements of `vec` are equal to `val`.
"""
_vec_value_check(vec, val)::Bool = all(vec .== val)
