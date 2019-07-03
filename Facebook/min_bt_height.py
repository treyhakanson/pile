class Node:
    def __init__(self , key):
        self.data = key
        self.left = None
        self.right = None


def min_bt_height(node):
    q = [node]
    depth = 0
    while len(q):
        node = q.pop(0)
        if not node.left or not node.right:
            return depth
        q.append(node.left)
        q.append(node.right)
        depth += 1
    return depth


root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
print(min_bt_height(root))
