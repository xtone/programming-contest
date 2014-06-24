# !/usr/bin/python
import sys
import re

def check_board(board, case):
    w = len(board[0])
    h = len(board)
    print "Case %d, width=%d, height=%d" % (case, w, h)
    strBoard = []
    intBoard = []
    mine = 0
    for line in board:
        mine += line.count('*')
        intLine = []
        strBoard.append(list(line))
        for i in range(0, len(line)):
            intLine.append(0)
        intBoard.append(intLine)

    cx = 0
    cy = 0
    for (y, line) in enumerate(strBoard):
        for (x, c) in enumerate(line):
            if c == '*':
                for yDiff in range(-1, 2):
                    tmpY = y + yDiff
                    if tmpY < 0 or h <= tmpY:
                        continue
                    for xDiff in range(-1, 2):
                        tmpX = x + xDiff
                        if tmpX < 0 or w <= tmpX:
                            continue
                        if tmpX == x and tmpY == y:
                            continue
                        intBoard[tmpY][tmpX] += 1

    for x in range(0, w):
        for y in range(0, h):
            if strBoard[y][x] == '.':
                isValid = False
                for xDiff in range(-1, 2):
                    tmpX = x + xDiff
                    if tmpX < 0 or w <= tmpX:
                        continue
                    for yDiff in range(-1, 2):
                        tmpY = y + yDiff
                        if tmpY < 0 or h <= tmpY:
                            continue
                        if tmpX == x and tmpY == y:
                            continue
                        if strBoard[tmpY][tmpX] == '*':
                            continue

                        if intBoard[tmpY][tmpX] == 0:
                            isValid = True
                if not isValid:
                    print "Should be impossible"
                    return
    print "OK"
    return

#main
r_file = sys.stdin

if len(sys.argv) > 1:
    r_file = open(sys.argv[1], 'r')

board = []
count = -1
while True:
    line = r_file.readline()
    if not line:
        if len(board) > 0:
            check_board(board, count + 1)
            board = []
        break

    if line.startswith("Case"):
        count += 1
        if len(board) > 0:
            check_board(board, count)
            board = []
        continue

    if line.startswith("Imp"):
        continue

    board.append(line.strip())
