def gen_fib(mx):
    fib = {1}
    prev = 1
    cur = 1

    while cur <= mx:
        tmp = cur
        cur += prev
        prev = tmp
        fib.add(cur)

    return fib


def fibonacci_subset(arr):
    mx = max(arr)
    fib = gen_fib(mx)
    subset = []
    start_i = 0
    mx_i = 0
    mx = 0

    for i, x in enumerate(arr):
        if len(subset) > mx:
            mx = len(subset)
            mx_i = start_i
        if x in fib:
            subset.append(x)
        else:
            subset.clear()
            start_i = i + 1

    if len(subset) > mx:
        mx = len(subset)
        mx_i = start_i

    return arr[mx_i:mx_i + mx]


arr = [1, 1, 10, 5, 3, 8, 8]
subset = fibonacci_subset(arr)
print(subset)
