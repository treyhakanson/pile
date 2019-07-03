class BinaryTree():
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


def sum_paths(bt):
    stack = []
    stack.append((bt, 0))
    path_values = []

    while len(stack):
        node, path_num = stack.pop()
        path_num *= 10
        path_num += node.value

        if not node.left and not node.right:
            path_values.append(path_num)

        if node.left:
            stack.append((node.left, path_num))

        if node.right:
            stack.append((node.right, path_num))

    return sum(path_values)


if __name__ == "__main__":
    root = BinaryTree(6)
    c1 = BinaryTree(3)
    c2 = BinaryTree(5)
    c3 = BinaryTree(4)
    c4 = BinaryTree(2)
    c5 = BinaryTree(5)
    c6 = BinaryTree(7)
    c7 = BinaryTree(4)

    root.left = c1
    root.right = c2
    root.right.right = c3
    root.left.left = c4
    root.left.right = c5
    root.left.right.left = c6
    root.left.right.right = c7

    path_sum = sum_paths(root)
    print(path_sum)
