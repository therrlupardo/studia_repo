def vec_zeros(_length):
    __vec = []
    for _ in range(_length):
        __vec.append(0)
    return __vec


def vec_ones(_length):
    __vec = []
    for _ in range(_length):
        __vec.append(1.0)
    return __vec


def diagonal(_a):
    __diag = []
    for __i in range(len(_a)):
        __diag.append(_a[__i][__i])
    return __diag


def copy_vector(_vector):
    __copy = []
    for __elem in _vector:
        __copy.append(__elem)
    return __copy


def vector_sub_vector(_a, _b):
    __tmp = copy_vector(_a)
    for __i in range(len(__tmp)):
        __tmp[__i] -= _b[__i]
    return __tmp


def vector_add_vector(_a, _b):
    __tmp = copy_vector(_a)
    for __i in range(len(__tmp)):
        __tmp[__i] += _b[__i]
    return __tmp


def norm(_vector):
    __counter = 0
    for __elem in _vector:
        __counter += __elem ** 2
    return __counter ** 0.5
