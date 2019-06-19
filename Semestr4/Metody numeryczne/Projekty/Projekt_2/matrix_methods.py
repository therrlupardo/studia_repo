def copy_matrix(_matrix):
    __copy = []
    for __row in _matrix:
        __new_row = []
        for __elem in __row:
            __new_row.append(__elem)
        __copy.append(__new_row)
    return __copy


def matrix_sub_matrix(_a, _b):
    __tmp = copy_matrix(_a)
    for __i in range(len(__tmp)):
        for __j in range(len(__tmp[0])):
            __tmp[__i][__j] -= _b[__i][__j]
    return __tmp


def matrix_add_matrix(_a, _b):
    __tmp = copy_matrix(_a)
    for __i in range(len(__tmp)):
        for __j in range(len(__tmp[0])):
            __tmp[__i][__j] += _b[__i][__j]
    return __tmp


def matrix_zeros(_x, _y):
    __matrix = []
    for _ in range(_y):
        __row = []
        for _ in range(_x):
            __row.append(int(0))
        __matrix.append(__row)
    return __matrix


def diagonal_to_square_matrix(_vector):
    __tmp = matrix_zeros(len(_vector), len(_vector))
    for __i in range(len(_vector)):
        __tmp[__i][__i] = _vector[__i]
    return __tmp
