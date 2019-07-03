from collections import defaultdict


def rearrange_str(s):
    count = 0
    letters = defaultdict(int)
    start_char = ord("A")

    for char in s:
        if char.isdigit():
            count += int(char)
        else:
            letters[char] += 1

    s2 = ""
    for i in range(start_char, start_char + 26):
        char = chr(i)
        if letters[char]:
            s2 += char * letters[char]
    s2 += str(count)

    return s2


s = "ACCBA10D2EW30"
s2 = rearrange_str(s)
print(s2, "\nAABCCDEW6")
