function magic_fast(n::Int)
    @assert n>0 "$n must be positive"
    #@assert mod(n, 4)≠2 "Unimplemented: Cannot construct magic square of order $n (yet)"

    if mod(n, 2) == 1
        return odd_magic_square(n)
    end

    if mod(n, 4) == 0
        return double_even_magic_square(n)
    end

    return single_even_magic(n)
end
