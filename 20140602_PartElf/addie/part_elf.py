#!/usr/bin/python
import sys, fractions

#solve case function
def solve_case(p, q, case_number):
    gcd = fractions.gcd(p, q)
    p = p / gcd
    q = q / gcd
    if q % p == 0:
        q /= p
        p = 1
    for g in range(1, 40):
        if q % 2 != 0:
            print "Case #%d: impossible" % case_number
            return
        q /= 2
        if 1 == q:
            while p > 1:
                p /= 2
                g -= 1
            print "Case #%d: %d" % (case_number, g)
            return

    print "Case #%d: impossible" % case_number

#main
r = sys.stdin

if len(sys.argv) > 1:
    r = open(sys.argv[1], 'r')

total_cases = r.readline()
for case_number in range(1, int(total_cases) + 1):
    pq = map(int, r.readline().strip().split('/'))
    solve_case(pq[0], pq[1], case_number)
