from math import sin


class Matrix:
    def __init__(self, index):
        self.d = int(index % 10)
        index /= 10
        self.c = int(index % 10)
        index /= 10
        self.e = int(index % 10)
        index /= 10
        self.f = int(index % 10)
        self.N = int(9 * self.c * self.d)

    def create_matrix(self, a1, a2, a3):
        __A = []
        for __i in range(self.N):
            __row = []
            for __j in range(self.N):
                if __i == __j:
                    __row.append(a1)
                elif __i - 1 <= __j <= __i + 1:
                    __row.append(int(a2))
                elif __i - 2 <= __j <= __i + 2:
                    __row.append(int(a3))
                else:
                    __row.append(int(0))
            __A.append(__row)
        return __A

    def create_matrix_a(self):
        return self.create_matrix(int(self.e + 5), -1, -1)

    def create_vector_b(self):
        __b = []
        for __i in range(self.N):
            __b.append(sin(__i * (self.f + 1)))
        return __b

    def create_matrix_c(self):
        return self.create_matrix(3, -1, -1)
