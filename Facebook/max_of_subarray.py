def max_of_subarray(arr, k):
    maxes = []
    if len(arr) < k:
        return maxes
    start = 0
    stop = k
    while stop - 1 < len(arr):
        maxes.append(max(arr[start:stop]))
        start += 1
        stop += 1
    return maxes


arr = [8, 5, 10, 7, 9, 4, 15, 12, 90, 13]
k = 4
print(max_of_subarray(arr, k))
