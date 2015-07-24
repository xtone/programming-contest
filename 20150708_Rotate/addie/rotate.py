import sys


def max_run_length(line):
    count = [0, 0]
    max_count = [0, 0]

    prev = '.'
    for c in line:
        if c != prev:
            if prev == 'R':
                if count[0] > max_count[0]:
                    max_count[0] = count[0]
            elif prev == 'B':
                if count[1] > max_count[1]:
                    max_count[1] = count[1]
            if c == 'R':
                count[0] = 1
            elif c == 'B':
                count[1] = 1
        else:
            if c == 'R':
                count[0] += 1
            elif c == 'B':
                count[1] += 1
        prev = c

    if count[0] > max_count[0]:
        max_count[0] = count[0]
    if count[1] > max_count[1]:
        max_count[1] = count[1]

    return max_count


# Hey, It's no problem if the world has gravity to right, isn't it?
def rotate_and_gravity(board):
    affected = []
    for line in board:
        fall_count = line.count('.')
        new_line = [c for c in line if c != '.']
        for x in range(0, fall_count):
            new_line.insert(0, '.')
        affected.append(new_line)
    return affected


def diagonal_lines(board):
    base = ['.'] * (len(board) * 2 - 1)
    lines_a = []
    lines_b = []
    for idx, c in enumerate(board):
        new_line = base[:]
        new_line[idx:idx + len(c)] = c
        lines_a.append(new_line)

        new_line = base[:]
        if idx == 0:
            new_line[-1 * len(c):] = c
        else:
            new_line[-1 * (idx + len(c)): -1 * idx] = c
        lines_b.append(new_line)

    return zip(*lines_a), zip(*lines_b)


def solve_case(k, board, case_number):
    rotated = rotate_and_gravity(board)
    b = rotated[:]
    for c in zip(*rotated):
        b.append(c)
    diagonals = diagonal_lines(rotated)
    for c in diagonals[0]:
        b.append(c)
    for c in diagonals[1]:
        b.append(c)

    red_win = False
    blue_win = False

    for c in b:
        mrl = max_run_length(c)
        if not red_win:
            if mrl[0] >= k:
                red_win = True
        if not blue_win:
            if mrl[1] >= k:
                blue_win = True
        if red_win and blue_win:
            break

    if red_win and blue_win:
        print "Case #%d: Both" % case_number
    elif not red_win and not blue_win:
        print "Case #%d: Neither" % case_number
    elif red_win and not blue_win:
        print "Case #%d: Red" % case_number
    elif not red_win and blue_win:
        print "Case #%d: Blue" % case_number


def main():
    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    for case_number in range(1, int(total_cases) + 1):
        nk = map(int, r.readline().strip().split(' '))
        board = []
        for i in range(0, nk[0]):
            board.append(list(r.readline().strip()))

        solve_case(nk[1], board, case_number)


if __name__ == '__main__':
    main()
