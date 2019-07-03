import sys
from queue import Queue


WHITE = "white"
GREY = "grey"
BLACK = "black"


class Node:
    def __init__(self, i, color=WHITE, d=sys.maxsize, pred=None):
        self.i = i
        self.color = color
        self.d = d
        self.pred = pred

    def __str__(self):
        return "(%d, %s, %d, %s)" % (self.i, self.color, self.d, self.pred)


def bfs(graph, s):
    """
    Performs a breadth first search on the input graph, starting at the input
    source.

    Args:
        graph {arrayOf(arrayOf(Node))} - the input graph, represented as an
        adjacency list
        s {Node} - the source to start the search at
    """
    s.color = GREY
    s.d = 0
    s.pred = None
    q = Queue()
    q.put(s)
    while q.qsize() is not 0:
        u = q.get()
        for v in graph[u.i]:
            if v.color == WHITE:
                v.color = GREY
                v.d = u.d + 1
                v.pred = u.i
                print(v)
                q.put(v)
        u.color = BLACK


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
    [s, v],
    [r, w],
    [w, x, u],
    [t, x, y],
    [r],
    [s, t, x],
    [w, t, u, y],
    [x, u]
]

bfs(graph, s)
