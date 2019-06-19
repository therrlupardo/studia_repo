import os
import csv
from matrices import matrix_methods, vector_methods, matrix_calculations
from matplotlib import pyplot


def interpolation_function(points):
    def calculate_params():
        n = len(points)

        # we have n points => n-1 intervals => 4*(n-1) equations
        # => 4*(n-1) x 4*(n-1) matrix A, and 4*(n-1) - element vectors x and b.
        # x = [a0, b0, c0, d0, a1, ...., an-1, bn-1, cn-1, dn-1], len(x) = 4*(n-1), where n = len(interpolation_data)

        A = matrix_methods.matrix_zeros(4 * (n - 1), 4 * (n - 1))
        b = vector_methods.vec_zeros(4 * (n - 1))

        # step 1: Si(xj) = f(xj)
        # n intervals => n-1 equations
        for i in range(n - 1):
            x, y = points[i]
            row = vector_methods.vec_zeros(4 * (n - 1))
            row[4 * i + 3] = 1
            A[4 * i + 3] = row
            b[4 * i + 3] = (float(y))

        # step 2: Sj(Xj+1) = f(Xj+1)
        # n intervals => n-1 equations
        # total : 2n-2 equations
        for i in range(n - 1):
            x1, y1 = points[i + 1]
            x0, y0 = points[i]
            h = float(x1) - float(x0)
            row = vector_methods.vec_zeros(4 * (n - 1))
            row[4 * i] = h ** 3
            row[4 * i + 1] = h ** 2
            row[4 * i + 2] = h ** 1
            row[4 * i + 3] = 1
            A[4 * i + 2] = row
            b[4 * i + 2] = float(y1)

        # step 3: for inner points, Sj-1'(xj) = Sj'(xj)
        # n points => n-2 inner points => n-2 equations
        # total : 3n-4 equations

        for i in range(n - 2):
            x1, y1 = points[i + 1]
            x0, y0 = points[i]
            h = float(x1) - float(x0)
            row = vector_methods.vec_zeros(4 * (n - 1))
            row[4 * i] = 3 * (h ** 2)
            row[4 * i + 1] = 2 * h
            row[4 * i + 2] = 1
            row[4 * (i + 1) + 2] = -1
            A[4 * i] = row
            b[4 * i] = float(0)

        # step 4: for inner points, Sj-1''(xj) = Sj''(xj)
        # n points => n-2 inner points => n-2 equations
        # total : 4n-6 equations

        for i in range(n - 2):
            x1, y1 = points[i + 1]
            x0, y0 = points[i]
            h = float(x1) - float(x0)
            row = vector_methods.vec_zeros(4 * (n - 1))
            row[4 * i] = 6 * h
            row[4 * i + 1] = 2
            row[4 * (i + 1) + 1] = -2
            A[4 * (i + 1) + 1] = row
            b[4 * (i + 1) + 1] = float(0)

        # step 5: on edges: S0''(x0) = 0 and Sn-1''(xn-1) = 0
        # 2 equations
        # total : 4n-4 equations

        # first point
        row = vector_methods.vec_zeros(4 * (n - 1))
        row[1] = 2
        A[1] = row
        b[1] = float(0)

        # last point
        row = vector_methods.vec_zeros(4 * (n - 1))
        x1, y1 = points[-1]
        x0, y0 = points[-2]
        h = float(x1) - float(x0)
        row[1] = 2
        row[-4] = 6 * h
        A[-4] = row
        b[-4] = float(0)

        result = matrix_calculations.lu_factorization(A, b)
        return result

    params = calculate_params()

    def f(x):
        param_array = []
        row = []
        for param in params:
            row.append(param)
            if len(row) == 4:
                param_array.append(row.copy())
                row.clear()

        for i in range(1, len(points)):
            xi, yi = points[i-1]
            xj, yj = points[i]
            if float(xi) <= x <= float(xj):
                a, b, c, d = param_array[i-1]
                h = x - float(xi)
                return a*(h**3)+b*(h**2)+c*h+d

        return -123

    return f


def interpolate_with_spline(k):
    for file in os.listdir('./data'):
        f = open('./data/'+file, 'r')
        data = list(csv.reader(f))

        data = data[1:]
        shift = (-1)*(len(data) % k)
        if shift != 0:
            interpolation_data = data[:shift:k]
        else:
            interpolation_data = data[::k]

        F = interpolation_function(interpolation_data)

        distance = []
        height = []
        interpolated_height = []
        for point in data:
            x, y = point
            distance.append(float(x))
            height.append(float(y))
            interpolated_height.append(F(float(x)))

        train_distance = []
        train_height = []
        for point in interpolation_data:
            x, y = point
            train_distance.append(float(x))
            train_height.append(float(y))

        shift = -1 * interpolated_height.count(-123)

        pyplot.plot(distance, height, 'r.', label='pełne dane')
        pyplot.plot(distance[:shift], interpolated_height[:shift], color='blue', label='funkcja interpolująca')
        pyplot.plot(train_distance, train_height, 'g.', label='dane do interpolacji')
        pyplot.legend()
        pyplot.ylabel('Wysokość')
        pyplot.xlabel('Odległość')
        pyplot.title('Przybliżenie interpolacją Splajnami, ' + str(len(interpolation_data)) + ' punkty(ów)')
        pyplot.suptitle(file)
        pyplot.grid()
        pyplot.show()
