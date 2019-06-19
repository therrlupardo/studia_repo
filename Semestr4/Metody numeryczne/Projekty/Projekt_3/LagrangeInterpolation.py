import math
import os
import csv
from matplotlib import pyplot


def interpolation_function(points):
    def f(x):
        result = 0
        n = len(points)
        for i in range(n):
            xi, yi = points[i]
            base = 1
            for j in range(n):
                if i == j:
                    continue
                else:
                    xj, yj = points[j]
                    base *= (float(x) - float(xj))/float(float(xi) - float(xj))
            result += float(yi) * base
        return result
    return f


def interpolate_with_lagrange(k):
    for file in os.listdir('./data'):
        f = open('./data/'+file, 'r')
        data = list(csv.reader(f))

        # prepare interpolating function

        # create data for function
        interpolation_data = data[1::k]

        # use data to create interpolating function F
        F = interpolation_function(interpolation_data)

        distance = []
        height = []
        interpolated_height = []
        for point in data[1:]:
            x, y = point
            distance.append(float(x))
            height.append(float(y))
            interpolated_height.append(F(float(x)))

        train_distance = []
        train_height = []
        for point in interpolation_data:
            x, y = point
            train_distance.append(float(x))
            train_height.append(F(float(x)))

        # odkomentowanie poniższych funkcji pozwoli na wyświetlenie fragmentów aproksymacji bez oscylacji
        #
        # n = math.floor(len(distance)/3)
        #
        # pyplot.plot(distance[n:2*n], height[n:2*n], 'r.', label='pełne dane')
        # pyplot.plot(distance[n:2*n], interpolated_height[n:2*n], color='blue', label='funkcja interpolująca')
        # pyplot.plot(train_distance[n:2*n], train_height[n:2*n], 'g.', label='dane do interpolacji')
        pyplot.semilogy(distance, height, 'r.', label='pełne dane')
        pyplot.semilogy(distance, interpolated_height, color='blue', label='funkcja interpolująca')
        pyplot.semilogy(train_distance, train_height, 'g.', label='dane do interpolacji')
        pyplot.legend()
        pyplot.ylabel('Wysokość')
        pyplot.xlabel('Odległość')
        pyplot.title('Przybliżenie interpolacją Lagrange\'a, ' + str(len(interpolation_data)) + ' punkty(ów)')
        pyplot.suptitle(file)
        pyplot.grid()
        pyplot.show()
