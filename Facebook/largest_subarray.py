def largest_subarray(arr, k):
    cur_max = arr[0]
    maxes = [arr[0]]
    for x in arr[1:]:
        cur_max = max(x, cur_max + x)
        maxes = cur_max



arr = []
k = 0
largest_subarray(arr, k)
