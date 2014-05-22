# -*- coding: utf-8 -*-
# !/usr/bin/python
import sys
import math


def debug_print(c, puts, n, m):
    for y in range(0, m):
        for x in range(0, n):
            if c == (x, y):
                print "●",
                continue
            if (x, y) in puts.keys():
                if puts[(x, y)]:
                    print "○",
                else:
                    print "×",
                continue
            print "□",
        print ""
    print ""


def create_candidate(puts, n, m):
    candidates = []
    key_list = puts.keys()
    keys = filter(lambda x: puts[x], key_list)
    for p in keys:
        if 0 < p[0]:
            pc = (p[0] - 1, p[1])
            if not pc in puts:
                candidates.append(pc)
        if 0 < p[1]:
            pc = (p[0], p[1] - 1)
            if not pc in puts:
                candidates.append(pc)
        if p[0] < n - 1:
            pc = (p[0] + 1, p[1])
            if not pc in puts:
                candidates.append(pc)
        if p[1] < m - 1:
            pc = (p[0], p[1] + 1)
            if not pc in puts:
                candidates.append(pc)
    return set(candidates)


def can_remove(candidate, puts):
    removed = False
    pc = (candidate[0] - 1, candidate[1])
    if pc in puts:
        if (pc[0] - 1, pc[1]) in puts.keys() and (pc[0], pc[1] - 1) in puts.keys() and (
                pc[0], pc[1] + 1) in puts.keys():
            puts[pc] = False
            removed = True
    pc = (candidate[0], candidate[1] - 1)
    if pc in puts:
        if (pc[0] - 1, pc[1]) in puts.keys() and (pc[0] + 1, pc[1]) in puts.keys() and (
                pc[0], pc[1] - 1) in puts.keys():
            puts[pc] = False
            removed = True
    pc = (candidate[0] + 1, candidate[1])
    if pc in puts:
        if (pc[0] + 1, pc[1]) in puts.keys() and (pc[0], pc[1] - 1) in puts.keys() and (
                pc[0], pc[1] + 1) in puts.keys():
            puts[pc] = False
            removed = True
    pc = (candidate[0], candidate[1] + 1)
    if pc in puts:
        if (pc[0] - 1, pc[1]) in puts.keys() and (pc[0] + 1, pc[1]) in puts.keys() and (
                pc[0], pc[1] + 1) in puts.keys():
            puts[pc] = False
            removed = True
    return removed


def max_neighbor(candidate, puts, n, m):
    tnc = 0
    pc = (candidate[0] - 1, candidate[1])
    nc = 0
    if 0 < pc[0] < n - 1 and 0 < pc[1] < m - 1:
        if (pc[0] - 1, pc[1]) in puts:
            nc += 1
        if (pc[0], pc[1] - 1) in puts:
            nc += 1
        if (pc[0], pc[1] + 1) in puts:
            nc += 1
        tnc += pow(10, nc)

    pc = (candidate[0], candidate[1] - 1)
    nc = 0
    if 0 < pc[0] < n - 1 and 0 < pc[1] < m - 1:
        if (pc[0] - 1, pc[1]) in puts:
            nc += 1
        if (pc[0] + 1, pc[1]) in puts:
            nc += 1
        if (pc[0], pc[1] - 1) in puts:
            nc += 1
        tnc += pow(10, nc)

    pc = (candidate[0] + 1, candidate[1])
    nc = 0
    if 0 < pc[0] < n - 1 and 0 < pc[1] < m - 1:
        if (pc[0] + 1, pc[1]) in puts:
            nc += 1
        if (pc[0], pc[1] + 1) in puts:
            nc += 1
        if (pc[0], pc[1] - 1) in puts:
            nc += 1
        tnc += pow(10, nc)

    pc = (candidate[0], candidate[1] + 1)
    nc = 0
    if 0 < pc[0] < n - 1 and 0 < pc[1] < m - 1:
        if (pc[0] + 1, pc[1]) in puts:
            nc += 1
        if (pc[0] - 1, pc[1]) in puts:
            nc += 1
        if (pc[0], pc[1] + 1) in puts:
            nc += 1
        tnc += pow(10, nc)

    return tnc


def score(candidate, puts, n, m):
    x = n / 2 - candidate[0]
    y = m / 2 - candidate[1]
    return max_neighbor(candidate, puts, n, m), (x * x) + (y * y)


def eval_score(candidates, puts, n, m):
    last_s = 0.0
    last_ss = float('inf')
    cc = None
    for c in candidates:

        s, ss = score(c, puts, n, m)
        if s > last_s:
            last_s = s
            last_ss = ss
            cc = c
            continue
        if s == last_s:
            if ss < last_ss:
                last_s = s
                last_ss = ss
                cc = c

    can_remove(cc, puts)
    return cc


# solve case function
def solve_case(n, m, k, case_number):
    if n < 3:
        print "Case #%d: %d" % (case_number, k)
        return

    puts = {}
    puts[((n / 2), (m / 2))] = True
    # c = ((n / 2), m / 2)
    for i in range(1, k):
        candidates = create_candidate(puts, n, m)
        c = eval_score(candidates, puts, n, m)
        # debug_print(c, puts, n, m)
        puts[c] = True
    print "Case #%d: %d" % (case_number, puts.values().count(True))

# main
r = sys.stdin

if len(sys.argv) > 1:
    r = open(sys.argv[1], 'r')

total_cases = r.readline()
for case_number in range(1, int(total_cases) + 1):
    nmk = map(int, r.readline().strip().split(' '))
    if nmk[0] < nmk[1]:
        nm = [nmk[0], nmk[1]]
    else:
        nm = [nmk[1], nmk[0]]
    solve_case(nm[0], nm[1], nmk[2], case_number)
