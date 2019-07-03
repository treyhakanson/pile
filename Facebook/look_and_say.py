import re


def look_and_say(n):
    seq = "1"
    regex = re.compile(r"(\d)\1*")

    for i in range(n - 1):
        next_seq = ""
        for match in regex.finditer(seq):
            n = len(match.group(0))
            char = match.group(0)[0]
            next_seq += f"{n}{char}"
        seq = next_seq

    return seq


print(look_and_say(5))
