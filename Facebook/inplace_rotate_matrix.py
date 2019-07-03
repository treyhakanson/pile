def rotate(mat):
    n = len(mat)
    for i in range(int(n / 2)):
        for j in range(i, n - i - 1):
            tmp = mat[i][j]
            mat[i][j] = mat[j][n - i - 1]
            mat[j][n - i - 1] = mat[n - i - 1][n - j - 1]
            mat[n - i - 1][n - j - 1] = mat[n - j - 1][i]
            mat[n - j - 1][i] = tmp


mat = [[1,  2,  3],
       [4,  5,  6],
       [7,  8,  9]]
rotate(mat)
print("\n".join([" ".join([str(cell) for cell in row]) for row in mat]), "\n")
exp = [[3, 6, 9],
       [2, 5, 8],
       [1, 4, 7]]
print("\n".join([" ".join([str(cell) for cell in row]) for row in exp]))
