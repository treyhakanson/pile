# Simple solution, O(n^2)
def sum_bit_differences_1(arr):
    diff = 0

    for x in arr:
        for y in arr:
            binary_str = bin(x ^ y)
            diff += len(binary_str) - len(binary_str.replace("1", ""))

    return diff


# Efficient solution, O(n)
def sum_bit_differences_2(arr):
    diff = 0
    n = len(arr)

    # Iterate over bit positions
    for bit_pos in range(0, 32):
        count = 0

        # Iterate over each arr element
        for x in arr:
            # If the element has a 1 in that position, increment the count
            if x & (1 << bit_pos):
                count += 1

        # Increment the number of differences at that position by the number of
        # numbers with 1 at that position, times the number of numbers with 0
        # at that position, times 2 since its a permutation not a combination
        # (counting both (x, y) and (y, x))
        diff += count * (n - count) * 2

    return diff


if __name__ == "__main__":
    test_cases = [([1, 3, 5], 8), ([1, 2], 4)]
    for i, test_case in enumerate(test_cases):
        arr, exp = test_case
        theo = sum_bit_differences_1(arr)
        print("sum_bit_differences_1:", theo, exp, theo == exp)
        theo = sum_bit_differences_2(arr)
        print("sum_bit_differences_2:", theo, exp, theo == exp)
        if i < len(test_cases) - 1:
            print()
