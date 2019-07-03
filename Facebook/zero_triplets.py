def zero_triplets(arr):
    triplets = []
    for i, x in enumerate(arr):
        s = set()
        for y in arr[i + 1:]:
            val = -(x + y)
            if val in s:
                triplets.append(f"{x} {y} {val}")
            else:
                s.add(y)
    return triplets


arr = [1, -2, 1, 0, 5]
print("\n".join(zero_triplets(arr)))
