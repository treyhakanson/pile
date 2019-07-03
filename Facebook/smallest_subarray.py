def smallest_subarray(arr, val):
    q = []
    total = 0
    min_len = None
    for i, x in enumerate(arr):
        q.append(x)
        total += x
        while total < 0:
            y = q.pop(0)
            total -= y
        if total > val:
            while total > val:
                if not min_len or min_len > len(q):
                    min_len = len(q)
                y = q.pop(0)
                total -= y
    return min_len



arr = [1, 11, 100, 1, 0, 200, 3, 2, 1, 250]
val = 280
min_len = smallest_subarray(arr, val)
print(f"Minimum length: {min_len}")
