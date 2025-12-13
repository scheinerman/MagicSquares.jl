# MagicSquares

Demonstration project using integer linear programming to create magic squares.

## Optimization Formulation

To find a magic square of order $n$, we use the following ILP:
* Let $m=n(n^2+1)/2$.
* $x_{i,j,k}$ is a 0,1-variable with $i,j\in[n]$ and $k\in[n^2]$. Indicates that the $i,j$-entry of the magic square is $k$. 
* Constraints:
    * Exactly one square has value $k$: $\forall k, \sum_{i,j} x_{i,j,k} = 1$ and $\forall i,j, \sum_k x_{i,j,k} = 1$. 
    * Row sums are $m$: $\forall i, \sum_j \sum_k k x_{i,j,k} = m$. 
    * Column sums are $m$: $\forall j, \sum_i \sum_k k x_{i,j,k} = m$. 
    * Diagonal sums are $m$: $\sum_i \sum_k k x_{i,i,k} = m$ and $\sum_i \sum_k k x_{i,n+1-i,k} = m$.
