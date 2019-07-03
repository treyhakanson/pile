def largest_word(d, s):
    longest = ""
    for word in d:
        if len(word) > len(s) or len(longest) > len(word):
            continue

        i = 0
        j = 0

        while i < len(s) and j < len(word):
            if word[j] == s[i]:
                j += 1
            i += 1

        if j == len(word):
            longest = word

    return longest


if __name__ == "__main__":
    d = ["ale", "apple", "monkey", "plea"]
    s = "abpcplea"
    d = ["pintu", "geeksfor", "geeksgeeks", " forgeek"]
    s = "geeksforgeeks"
    longest = largest_word(d, s)
    print(longest)
