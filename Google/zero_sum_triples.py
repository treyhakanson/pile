def zero_sum_triples(arr):
    triples = []
    for i, x in enumerate(arr[:-2]):
        for j, y in enumerate(arr[i + 1:-1]):
            for z in arr[j + 1:]:
                if x + y + z == 0:
                    triples.append((x, y, z))
    return triples


if __name__ == "__main__":
    arr = [0, -1, 2, -3, 1]
    triples = zero_sum_triples(arr)
    print(triples)
