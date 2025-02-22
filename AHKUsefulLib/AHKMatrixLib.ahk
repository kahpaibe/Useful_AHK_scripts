#Requires AutoHotkey v2.0

; AHK v2 library implementing Matrix objects

#Include AHKUsefulLib.ahk

/* Matrix(N, M) : Create a new matrix with dimensions N x M.
 * Args:
 *   N (Integer): Number of rows
 *   M (Integer): Number of columns 
 * 
 * Methods:
 * */
class Matrix
{
    rows := unset
    N := unset
    M := unset

    __New(N, M)
    {
        If !IsInteger(N) || !IsInteger(M)
            throw ValueError("Matrix dimensions must be integers. Here: Type(N=" N ") = " Type(N) ", Type(M=" M ") = " Type(M))
        If N <= 0 || M <= 0
            throw ValueError("Matrix dimensions must be positive. Here: N=" N ", M=" M)

        ; Fill the matrix with zeros
        this.N := N
        this.M := M
        this.rows := []
        For i in ArrayRange(1, N) {
            row := []
            For j in ArrayRange(1, M)
                row.Push(0)
            this.rows.Push(row)
        }
    }

    __Item[index] {
        get => this.rows[index]
        set => this.rows[index] := value
    }

    /* Matrix.Norm2() : Returns the squared Frobenius norm of the matrix.
     * Returns:
     *   Number: The squared Frobenius norm of the matrix */
    Norm2() {
        norm2 := 0
        For i in ArrayRange(1, this.N) {
            For j in ArrayRange(1, this.M) {
                norm2 += this.rows[i][j] ** 2
            }
        }
        return norm2
    }
}

/* MatrixOnes(N, M) : Create a matrix with dimensions N x M filled with ones.
 * Args:
 *   N (Integer): Number of rows
 *   M (Integer): Number of columns 
 * Returns:
 *   Matrix: The matrix filled with ones
 * */
MatrixOnes(N, M) {
    If !IsInteger(N) || !IsInteger(M)
        throw ValueError("Matrix dimensions must be integers. Here: Type(N=" N ") = " Type(N) ", Type(M=" M ") = " Type(M))
    If N <= 0 || M <= 0
        throw ValueError("Matrix dimensions must be positive. Here: N=" N ", M=" M)

    A := Matrix(N, M)
    For i in ArrayRange(1, N) {
        For j in ArrayRange(1, M) {
            A[i][j] := 1
        }
    }
    return A
}

/* MatrixIdentity(N) : Create an identity matrix with dimensions N x N.
 * Args:
 *   N (Integer): Number of rows and columns
 * Returns:
 *   Matrix: The identity matrix
 * */
MatrixIdentity(N) {
    If !IsInteger(N)
        throw ValueError("Matrix dimension must be an integer. Here: Type(N=" N ") = " Type(N))
    If N <= 0
        throw ValueError("Matrix dimension must be positive. Here: N=" N)

    A := Matrix(N, N)
    For i in ArrayRange(1, N) {
        A[i][i] := 1
    }
    return A
}

/* MatrixScale(A, k) : Scale a matrix A by a factor k.
 * Args:
 *   A (Matrix): The matrix to scale
 *   k (Number): The scaling factor
 * Returns:
 *   Matrix: The scaled matrix
 * */
MatrixScale(A, k) {
    If !IsObject(A)
        throw ValueError("Matrix A must be a Matrix object. Here: Type(A=" A ") = " Type(A))
    If !IsNumber(k)
        throw ValueError("Scaling factor k must be a number. Here: Type(k=" k ") = " Type(k))

    kA := Matrix(A.N, A.M)
    For i in ArrayRange(1, A.N) {
        For j in ArrayRange(1, A.M) {
            kA[i][j] := k * A[i][j]
        }
    }
    return kA
}

/* MatrixSum(A, B) :  Returns the sum of two matrices A and B.
 * Args:
 *   A (Matrix): The first matrix
 *   B (Matrix): The second matrix
 * Returns:
 *   Matrix: The sum of A and B
 * 
 * Note: The matrices must have the same dimensions.
 * */
MatrixSum(A, B) {
    If !IsObject(A) || !IsObject(B)
        throw ValueError("Matrix A and B must be Matrix objects. Here: Type(A=" A ") = " Type(A) ", Type(B=" B ") = " Type(B))
    If A.N != B.N || A.M != B.M
        throw ValueError("Matrix A and B must have the same dimensions for addition. Here: A.N=" A.N ", A.M=" A.M ", B.N=" B.N ", B.M=" B.M)
    
    C := Matrix(A.N, A.M)
    For i in ArrayRange(1, A.N) {
        For j in ArrayRange(1, A.M) {
            C[i][j] := A[i][j] + B[i][j]
        }
    }
    return C
}

/* MatrixMult(A, B) : Returns the product of two matrices A and B.
 * Args:
 *   A (Matrix): The first matrix
 *   B (Matrix): The second matrix
 * Returns:
 *   Matrix: The product of A and B
 * 
 * Note: The number of columns of A must be equal to the number of rows of B.
 * */
MatrixMult(A, B) {
    If !IsObject(A) || !IsObject(B)
        throw ValueError("Matrix A and B must be Matrix objects. Here: Type(A=" A ") = " Type(A) ", Type(B=" B ") = " Type(B))
    If A.M != B.N
        throw ValueError("Matrix A and B must have compatible dimensions for multiplication (A.M = B.N). Here: A.M=" A.M ", B.N=" B.N)
    
    C := Matrix(A.N, B.M)
    For i in ArrayRange(1, A.N) {
        For j in ArrayRange(1, B.M) {
            For k in ArrayRange(1, A.M) {
                C[i][j] += A[i][k] * B[k][j]
            }
        }
    }
    return C
}

/* MatrixTranspose(A) : Return transpose of a matrix A.
 * Args:
 *   A (Matrix): The matrix to transpose
 * Returns:
 *   Matrix: The transpose of A
 * */
MatrixTranspose(A) {
    If !IsObject(A)
        throw ValueError("Matrix A must be a Matrix object. Here: Type(A=" A ") = " Type(A))
    
    At := Matrix(A.M, A.N)
    For i in ArrayRange(1, A.N) {
        For j in ArrayRange(1, A.M) {
            At[j][i] := A[i][j]
        }
    }
    return At
}
