def count_strings(n, b, c):
    if b < 0 or c < 0:
        return 0
    if n == 0 or (b == 0 and c == 0):
        return 1

    res = count_strings(n - 1, b, c)
    res += count_strings(n - 1, b - 1, c)
    res += count_strings(n - 1, b, c - 1)

    return res


if __name__ == "__main__":
    n = 3
    b = 1
    c = 2
    count = count_strings(n, b, c)
    print(count)
