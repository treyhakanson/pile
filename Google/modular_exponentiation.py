#   125
#  / | \
# 5  5  5
#
# 125 % 3 = 2
# 5 % 3 = 2
# 2 * 2 * 2 = 8
# 8 % 3 = 2


# Simple solution, O(n)
def modular_exponentiation(x, y, p):
    # computes x^y % p
    # (x * x * x * ... * x) % p
    if y > 1:
        mod_exp = modular_exponentiation(x, y - 1, p)
        return (x % p * mod_exp) % p
    elif y == 1:
        return x % p
    else:
        return 1


if __name__ == "__main__":
    test_cases = [(2, 3, 5, 3), (2, 5, 13, 6)]
    for i, test_case in enumerate(test_cases):
        x, y, p, exp = test_case
        theo = modular_exponentiation(x, y, p)
        print("modular_exponentiation:", theo, exp, theo == exp)
        if i < len(test_cases) - 1:
            print()
