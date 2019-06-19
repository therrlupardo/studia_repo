import time

from matplotlib import pyplot

from vector_methods import *
from matrix_methods import *
from Matirx import *


def jacobi(_a, _b):
    # init
    __time0 = time.time()
    __matrix_a = copy_matrix(_a)
    __vector_b = copy_vector(_b)
    __k = 0
    __tmp_x = vec_zeros(len(__matrix_a))
    __x = copy_vector(__tmp_x)

    # perform
    while True:
        for __i in range(len(__matrix_a)):
            __value = __vector_b[__i]
            for __j in range(len(__matrix_a)):
                if __i != __j:
                    __value -= __matrix_a[__i][__j] * __x[__j]
            __value /= __matrix_a[__i][__i]
            __tmp_x[__i] = __value
        __x = copy_vector(__tmp_x)
        __res = vector_sub_vector(dot_product(__matrix_a, __x), __vector_b)

        if norm(__res) < pow(10, -9):
            break
        __k += 1

    # results
    print("Jacobi's method")
    print('time:', time.time() - __time0)
    print('iterations:', __k)
    print()
    return time.time()-__time0


def gauss_seidel(_a, _b):
    # init
    __time0 = time.time()
    __k = 0
    __matrix_a = copy_matrix(_a)
    __vector_b = copy_vector(_b)
    __vector_x = vec_zeros(len(__matrix_a[0]))

    # preform
    while True:
        for __i in range(len(__matrix_a)):
            __tmp = __vector_b[__i]
            for __j in range(len(__matrix_a)):
                if __i != __j:
                    __tmp -= __matrix_a[__i][__j] * __vector_x[__j]
            __tmp /= __matrix_a[__i][__i]
            __vector_x[__i] = __tmp

        __res = vector_sub_vector(dot_product(__matrix_a, __vector_x), __vector_b)
        if norm(__res) < pow(10, -9):
            break
        __k += 1

    # results
    print("Gauss-Seidel's method")
    print("time:", time.time() - __time0)
    print("iterations:", __k)
    print()
    return time.time()-__time0


def lu_factorization(_a, _b):
    # init
    __time0 = time.time()
    __m = len(_a)

    __matrix_a = copy_matrix(_a)
    __matrix_l = diagonal_to_square_matrix(vec_ones(__m))
    __matrix_u = matrix_zeros(__m, __m)

    __vector_b = copy_vector(_b)
    __vector_x = vec_ones(__m)
    __vector_y = vec_zeros(__m)

    # 1. perform - create matrices L and U
    # LUx = b
    for __j in range(__m):
        for __i in range(__j + 1):
            __matrix_u[__i][__j] += __matrix_a[__i][__j]
            for __k in range(__i):
                __matrix_u[__i][__j] -= __matrix_l[__i][__k] * __matrix_u[__k][__j]

        for __i in range(__j + 1, __m):
            for __k in range(__j):
                __matrix_l[__i][__j] -= __matrix_l[__i][__k] * __matrix_u[__k][__j]
            __matrix_l[__i][__j] += __matrix_a[__i][__j]
            __matrix_l[__i][__j] /= __matrix_u[__j][__j]

    # 3. perform - solve Ly = b
    for __i in range(__m):
        __value = __vector_b[__i]
        for __j in range(__i):
            __value -= __matrix_l[__i][__j] * __vector_y[__j]

        __vector_y[__i] = __value / __matrix_l[__i][__i]

    # 4. perform - solve Ux = y
    for __i in range(__m - 1, -1, -1):
        __value = __vector_y[__i]
        for __j in range(__i + 1, __m):
            __value -= __matrix_u[__i][__j] * __vector_x[__j]
        __vector_x[__i] = __value / __matrix_u[__i][__i]

    # results
    __res = vector_sub_vector(dot_product(__matrix_a, __vector_x), __vector_b)
    print("LU method")
    print('time:', time.time() - __time0)
    print("Residuum norm:", norm(__res))
    print()
    return time.time()-__time0


def dot_product(_a, _b):
    __copy_a = copy_matrix(_a)
    __copy_b = copy_vector(_b)
    __m = len(__copy_a)
    __n = len(__copy_a[0])
    __c = vec_zeros(__m)

    for __i in range(__m):
        for l in range(__n):
            __c[__i] += __copy_a[__i][l] * __copy_b[l]
    return __c


if __name__ == "__main__":
    # A
    matrix_base = Matrix(171619)
    matrix_A = matrix_base.create_matrix_a()
    vector_b = matrix_base.create_vector_b()
    # B
    jacobi(matrix_A, vector_b)
    gauss_seidel(matrix_A, vector_b)

    # C
    matrix_C = matrix_base.create_matrix_c()
    # jacobi(matrix_C, vector_b)  # błąd przy 1280 iteracji

    # gauss_seidel(matrix_C, vector_b)  # błąd przy 619 iteracji

    # D
    lu_factorization(matrix_C, vector_b)

    # E
    N = [100, 500, 1000, 2000, 3000]
    time_jacobi = []
    time_gs = []
    time_lu = []
    for n in N:
        print("Size:", n)
        matrix_base.N = n
        matrix_A = matrix_base.create_matrix_a()
        vector_b = matrix_base.create_vector_b()

        time_jacobi.append(jacobi(matrix_A, vector_b))
        time_gs.append(gauss_seidel(matrix_A, vector_b))
        time_lu.append(lu_factorization(matrix_A, vector_b))

    pyplot.plot(N, time_jacobi, label="Jacobi", color="red")
    pyplot.plot(N, time_gs, label="Gauss-Seidl", color="blue")
    pyplot.plot(N, time_lu, label="LU", color="green")
    pyplot.legend()
    pyplot.grid(True)
    pyplot.ylabel('Czas (s)')
    pyplot.xlabel('Liczba niewiadomych')
    pyplot.title('Zależność czasu od liczby niewiadomych')
    pyplot.show()
