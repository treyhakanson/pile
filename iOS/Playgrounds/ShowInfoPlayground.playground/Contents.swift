var dict = Dictionary<Int, Int>()

if dict[1] == nil {
    dict[1] = 1
} else {
    dict[1] = dict[1]! + 1
}

dict[1] = (dict[1] != nil) ? dict[1]! + 1 : 1







