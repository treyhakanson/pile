"""
Is there a path starting in the upper left hand corner that follows walkable
spaces (1s) to the goal point (9)?
"""

grid = [["1", "1", "1", "#", "#", "#", "#", "#", "#", "#"],
        ["1", "1", "#", "#", "1", "#", "#", "#", "#", "#"],
        ["#", "1", "#", "#", "1", "#", "#", "#", "#", "#"],
        ["#", "1", "1", "1", "1", "#", "#", "#", "#", "#"],
        ["#", "#", "1", "#", "1", "1", "1", "#", "#", "#"],
        ["#", "#", "1", "#", "1", "#", "1", "#", "#", "#"],
        ["#", "#", "1", "1", "1", "1", "1", "#", "#", "#"],
        ["#", "#", "#", "#", "#", "1", "#", "#", "#", "#"],
        ["#", "#", "#", "1", "1", "1", "1", "1", "1", "#"],
        ["#", "#", "#", "1", "#", "1", "#", "#", "#", "#"]]


def search(grid, pt, visited, rows, cols):
    row, col = pt
    if pt in visited:
        return False
    if row > rows - 1 or \
       col > cols - 1 or \
       row < 0 or \
       col < 0:
        return False
    if grid[row][col] == "9":
        return True
    elif grid[row][col] != "1":
        return False
    visited.add(pt)
    return (search(grid, (row - 1, col), visited, rows, cols) or
            search(grid, (row + 1, col), visited, rows, cols) or
            search(grid, (row, col - 1), visited, rows, cols) or
            search(grid, (row, col + 1), visited, rows, cols))


visited = set()
pt = (0, 0)
rows = len(grid)
cols = len(grid[0])
res = search(grid, pt, visited, rows, cols)
print(res)
