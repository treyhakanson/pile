d = {"I": 1,
     "V": 5,
     "X": 10,
     "L": 50,
     "C": 100,
     "D": 500,
     "M": 1000}


def roman_value(s):
    value = 0
    prev = d[s[0]]
    for numeral in s[1:]:
        if prev < d[numeral]:
            value += d[numeral] - prev
        else:
            value += d[numeral] + prev
        prev = d[numeral]
    return value


value = roman_value("")
print(value)
