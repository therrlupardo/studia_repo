
from matrices.vector_methods import *
from matrices.matrix_methods import *


def lu_factorization(_a, _b):
    # init
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
    return __vector_x


def gauss_seidel(_a, _b):
    # init
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

    return __res


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

