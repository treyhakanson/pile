def pair_differences(arr, k):
    count = 0
    for i, x in enumerate(arr):
        for y in arr[i:]:
            count += abs(x - y) == k
    return count


arr = [8, 12, 16, 4, 0, 20]
k = 4
n = pair_differences(arr, k)
print(n)
