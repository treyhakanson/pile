from math import floor


def check_board(board, x, i, j):
    # Check if in row
    if x in board[i]:
        return False

    # Check if in column
    for k in range(len(board)):
        if board[k][j] == x:
            return False

    # Check if in 3 x 3
    grid_r = floor(i / 3)
    grid_c = floor(j / 3)

    for k in range(3):
        for l in range(3):
            if x == board[grid_r * 3 + k][grid_c * 3 + l]:
                return False

    return True


def sudoku(board):
    n = len(board)
    for i in range(n):
        for j in range(n):
            if board[i][j] != 0:
                continue
            value = 0
            for x in range(1, 10):
                if not check_board(board, x, i, j):
                    continue
                value = x
                break
            if not value:
                return board
            board[i][j] = x
            sudoku(board)


if __name__ == "__main__":
    board = []
    sudoku(board)
