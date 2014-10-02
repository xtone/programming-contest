import sys


# This method is ONLY for debug.
def print_board(board):
    for row in board:
        print "".join(map(str, row))


def valid_top_left(board):
    n = len(board[0]) / 2
    normal_lines = set(board)
    if len(normal_lines) != 2:
        return None, None
    if False in map(lambda l: l.count("1") == n, normal_lines):
        return None, None

    rotated_lines = set(zip(*board))
    if len(rotated_lines) != 2:
        return None, None
    if False in map(lambda l: l.count("1") == n, rotated_lines):
        return None, None

    return normal_lines.pop(), rotated_lines.pop()


def count_manipulation(boards):
    n = len(boards[0])
    top = int(boards[0], 2)
    left = int("".join(boards[1]), 2)
    row = int("01" * (n / 2), 2)

    t = bin(top ^ row).count("1")
    t = min(t / 2, (n - t) / 2)
    l = bin(left ^ row).count("1")
    l = min(l / 2, (n - l) / 2)
    return t + l


def solve_case(boards, case_number):
    if None in boards:
        print "Case #%d: IMPOSSIBLE" % case_number
        return

    count = count_manipulation(boards)
    print "Case #%d: %d" % (case_number, count)


def main():
    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    for case_number in range(1, int(total_cases) + 1):
        n = int(r.readline()) * 2
        board = []
        for i in range(0, n):
            board.append(r.readline().strip())

        solve_case(valid_top_left(board), case_number)


main()
