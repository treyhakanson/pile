def partition(arr, low, high):
    i = low
    pivot = arr[high]

    for j in range(low, high):
        if arr[j] < pivot:
            tmp = arr[j]
            arr[j] = arr[i]
            arr[i] = tmp
            i += 1

    tmp = arr[high]
    arr[high] = arr[i]
    arr[i] = tmp

    return i


def quick_sort(arr, low, high):
    if low < high:
        pivot = partition(arr, low, high)
        quick_sort(arr, low, pivot - 1)
        quick_sort(arr, pivot + 1, high)


def sort(arr):
    quick_sort(arr, 0, len(arr) - 1)


if __name__ == "__main__":
    arr = [3, 7, 9, 2, 1, 8, 7, 3, 9, 1]
    arr2 = arr.copy()
    sort(arr)
    arr2.sort()
    print(arr)
    print(arr2)
    print(arr == arr2)
