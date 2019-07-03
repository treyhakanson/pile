def longest_subsequence(x, y):
    n = len(x)
    m = len(y)
    memo = [[None] * (m + 1) for _ in range(n + 1)]

    for i in range(n + 1):
        for j in range(m + 1):
            if i == 0 or j == 0:
                memo[i][j] = 0
            elif x[i - 1] == y[j - 1]:
                memo[i][j] = memo[i - 1][j - 1] + 1
            else: # x[i - 1] != y[j - 1]
                memo[i][j] = max(memo[i - 1][j], memo[i][j - 1])

    print("\n".join([" ".join([str(x) for x in row]) for row in memo]))
    return memo[n][m]

x = "AGGTAB"
y = "GXTXAYB"
print(longest_subsequence(x, y))
