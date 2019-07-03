def meta_strings(s1, s2):
    if len(s1) != len(s2):
        return False

    count = 0
    indices = []
    for i, char in enumerate(s1):
        if char != s2[i]:
            count += 1
            indices.append(i)
            if count > 2:
                return False

    i, j = indices
    return s1[i] == s2[j] and s1[j] == s2[i]


if __name__ == "__main__":
    s1 = "string"
    s2 = "rsting"
    are_meta = meta_strings(s1, s2)
    print(are_meta)
