def k_palindrome(s, k):
    for i, x in enumerate(s):
        left = x[x:i]
        right = x[i+1:]
        forward = 
