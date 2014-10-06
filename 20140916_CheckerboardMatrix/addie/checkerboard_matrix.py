import sys

ROW_1_BASE = "01"
ROW_2_BASE = "10"


# This method is ONLY for debug.
def print_board(board):
    for row in board:
        print "".join(map(str, row))


def is_validable_board(board):
    n = len(board[0]) / 2
    for row in board:
        if row.count(1) != n:
            return False

    for row in zip(*board):
        if row.count(1) != n:
            return False

    return True


def is_valid_board(board):
    n = len(board[0]) / 2
    rows = [int(ROW_1_BASE * n, 2), int(ROW_2_BASE * n, 2)]
    for i, row in enumerate(board):
        if rows[i % 2] != int("".join(map(str, row)), 2):
            break
    else:
        return True

    for i, row in enumerate(board):
        if rows[1 - i % 2] != int("".join(map(str, row)), 2):
            break
    else:
        return True

    return False


def swap_row_if_needed(board, base):
    swapper = [[], []]
    for i, row in enumerate(board):
        b = (i % 2) ^ base
        if row[0] == b:
            continue
        else:
            swapper[b].append(i)
    count = 0
    for swap_index in zip(*swapper):
        count += 1
        swap_row(board, swap_index[0], swap_index[1])
    return count


def manipulate_by_base(board, r_base, c_base):
    count = swap_row_if_needed(board, r_base)
    board = zip(*board)
    count += swap_row_if_needed(board, c_base)

    if is_valid_board(board):
        return count
    else:
        return None


def manipulate(board):
    base_1 = manipulate_by_base(board[:], 0, 0)
    base_2 = manipulate_by_base(board[:], 1, 1)
    base_3 = manipulate_by_base(board[:], 1, 0)
    base_4 = manipulate_by_base(board[:], 0, 1)

    return min(base_1, base_2, base_3, base_4)


def swap_row(board, row_index_1, row_index_2):
    board[row_index_1], board[row_index_2] = board[row_index_2], board[row_index_1]


def swap_column(board, column_index_1, column_index_2):
    for row in board:
        row[column_index_1], row[column_index_2] = row[column_index_2], row[column_index_1]


def solve_case(board, case_number):
    if not is_validable_board(board):
        print "Case #%d: IMPOSSIBLE" % case_number
        return

    count = manipulate(board)
    if count is not None:
        print "Case #%d: %d" % (case_number, count)
    else:
        print "Case #%d: IMPOSSIBLE" % case_number


def main():
    sys.setrecursionlimit(2000)

    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    for case_number in range(1, int(total_cases) + 1):
        n = int(r.readline())
        board = []
        for i in range(0, n * 2):
            row = map(int, list(r.readline().strip()))
            board.append(row)
        solve_case(board, case_number)


main()
