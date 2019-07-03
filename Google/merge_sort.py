def merge(arr, l, m, r):
    n_l = m - l + 1
    n_r = r - m

    arr_l = arr[l:m + 1].copy()
    arr_r = arr[m + 1: r + 1].copy()

    i = 0
    j = 0
    k = l

    while i < n_l and j < n_r:
        if arr_l[i] < arr_r[j]:
            arr[k] = arr_l[i]
            i += 1
        else:
            arr[k] = arr_r[j]
            j += 1
        k += 1

    while i < n_l:
        arr[k] = arr_l[i]
        i += 1
        k += 1

    while j < n_r:
        arr[k] = arr_r[j]
        j += 1
        k += 1


def merge_sort(arr, l, r):
    if l < r:
        m = int((l + r) / 2)
        merge_sort(arr, l, m)
        merge_sort(arr, m + 1, r)
        merge(arr, l, m, r)


def sort(arr):
    merge_sort(arr, 0, len(arr) - 1)


if __name__ == "__main__":
    arr = [3, 7, 9, 2, 1, 8, 7, 3, 9, 1]
    arr2 = arr.copy()
    sort(arr)
    arr2.sort()
    print(arr)
    print(arr2)
    print(arr == arr2)
