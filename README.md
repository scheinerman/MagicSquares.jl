# MagicSquares

Demonstration project using integer linear programming to create magic squares.


## Creating magic squares using integer linear programming [ILP]

Use `magic(n)` to create a magic square of order `n`. This is an `n`-by-`n` matrix whose entries are the numbers `1` through `n^2` such that the sum of the entries in every row, every column, and the two diagonals is the same. 

This is done via integer linear programming. Consquently, it is slow.
```
julia> @time magic(6)
111.030697 seconds (220.59 k allocations: 16.619 MiB, 0.01% gc time)
6×6 Matrix{Int64}:
 23   2  29  35  12  10
 32   4   3  25  33  14
  9  21  24   6  36  15
 27  28  13  20   7  16
  1  30  11  17  18  34
 19  26  31   8   5  22
```

### Changing solver

By default, the HiGHS solver is used to solve the ILP. Gurobi is much faster.
```
julia> using ChooseOptimizer, Gurobi

julia> set_solver(Gurobi)

julia> @time magic(6)
  2.087627 seconds (51.31 k allocations: 3.246 MiB)
6×6 Matrix{Int64}:
 14  19  24   1  33  20
 18  31  15  27   8  12
  5  35   4  34  26   7
 28   6  22  10  13  32
 30  11  21   3  29  17
 16   9  25  36   2  23
```


### Formulation

To find a magic square of order $n$, we use the following ILP:
* Let $m=n(n^2+1)/2$.
* $x_{i,j,k}$ is a 0,1-variable with $i,j\in[n]$ and $k\in[n^2]$. Indicates that the $i,j$-entry of the magic square is $k$. 
* Constraints:
    * Every cell has a value and exactly one square has value $k$: $\forall k, \sum_{i,j} x_{i,j,k} = 1$ and $\forall i,j, \sum_k x_{i,j,k} = 1$. 
    * Row sums are $m$: $\forall i, \sum_j \sum_k k x_{i,j,k} = m$. 
    * Column sums are $m$: $\forall j, \sum_i \sum_k k x_{i,j,k} = m$. 
    * Diagonal sums are $m$: $\sum_i \sum_k k x_{i,i,k} = m$ and $\sum_i \sum_k k x_{i,n+1-i,k} = m$.

## Fast generation of odd magic squares

The function `odd_magic_square(n)` rapidly creates a magic square of order `n` provided `n` is odd.
```
julia> @time odd_magic_square(7)
  0.000010 seconds (23 allocations: 3.391 KiB)
7×7 Matrix{Int64}:
 30  39  48   1  10  19  28
 38  47   7   9  18  27  29
 46   6   8  17  26  35  37
  5  14  16  25  34  36  45
 13  15  24  33  42  44   4
 21  23  32  41  43   3  12
 22  31  40  49   2  11  20
```


## Check function

The function `magic_check` checks if a matrix is a properly formed magic square. 

```
julia> M = magic(5)
5×5 Matrix{Int64}:
  6  13  22   7  17
 12  24  18   8   3
 19  10   1  14  21
  5  16   4  25  15
 23   2  20  11   9

julia> magic_check(M)
true

julia> M = ones(Int,5,5)
5×5 Matrix{Int64}:
 1  1  1  1  1
 1  1  1  1  1
 1  1  1  1  1
 1  1  1  1  1
 1  1  1  1  1

julia> magic_check(M)
false
```