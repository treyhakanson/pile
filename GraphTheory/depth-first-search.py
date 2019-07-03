from sys import maxsize

WHITE = "white"
GREY = "grey"
BLACK = "black"


class Node:
    def __init__(self, i, color=WHITE, d=maxsize, f=maxsize, pred=None):
        self.i = i
        self.color = color
        self.d = d
        self.f = f
        self.pred = pred

    def __str__(self):
        return "(%d, %s, %d, %s)" % (self.i, self.color, self.d, self.pred)


def dfs_visit(graph, u, time):
    time += 1
    u.d = time
    u.color = GREY
    for v in graph[u.i][1]:
        if v.color == WHITE:
            v.pred = u.i
            print(v)
            dfs_visit(graph, v, time)
    u.color = BLACK
    time += 1
    u.f = time


def dfs(graph, s):
    """
    Performs a depth first search on the input graph, starting at the input
    source.

    Args:
        graph {arrayOf(arrayOf(Node))} - the input graph, represented as an
        adjacency list
        s {Node} - the source to start the search at
    """
    time = 0
    for u, adj in graph:
        if u.color == WHITE:
            dfs_visit(graph, u, time)


"""
Graph:
(r)-----(s)     (t)-----(u)
 |       |    /  |    /  |
 |       |  /    |  /    |
(v)     (w)-----(x)-----(y)
"""

r = Node(0)
s = Node(1)
t = Node(2)
u = Node(3)
v = Node(4)
w = Node(5)
x = Node(6)
y = Node(7)

graph = [
    (r, [s, v]),
    (s, [r, w]),
    (t, [w, x, u]),
    (u, [t, x, y]),
    (v, [r]),
    (w, [s, t, x]),
    (x, [w, t, u, y]),
    (y, [x, u])
]

dfs(graph, s)
