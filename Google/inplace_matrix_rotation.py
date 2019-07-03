import math


def inplace_matrix_rotation(mat):
    n = len(mat)
    cycles = math.ceil(n / 2)

    for i in range(cycles):
        pass


if __name__ == "__main__":
    test_cases = [([[1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9]],
                   [[3, 6, 9],
                    [2, 5, 8],
                    [1, 4, 7]])]
    for i, test_case in enumerate(test_cases):
        mat, exp = test_case
        theo = inplace_matrix_rotation(mat)
        print("sum_bit_differences_1:", theo, exp, theo == exp)
        if i < len(test_cases) - 1:
            print()
