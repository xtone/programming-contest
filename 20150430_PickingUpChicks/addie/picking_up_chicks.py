import sys


def solve_case(k, b, t, ns, vs, cn):
    gs = []
    for n, v in zip(ns, vs):
        g = n + (v * t)
        gs.append(g)

    goaled = [x for x in gs if x >= b]

    n = len(ns)
    swap_flags = [0] * n
    goaled.reverse()
    gs.reverse()
    for g in goaled:
        for idx, gg in enumerate(gs):
            if gg == g and swap_flags[idx] == 0:
                swap_flags[idx] = 1
                break
        else:
            continue
        # inner for loop is broken
        if swap_flags.count(1) == k:
            break
    else:
        # outer for loop is NOT broken, which means not enough chicks arrived at the barn.
        print "Case #%d: IMPOSSIBLE" % cn
        return

    swap_flags.reverse()

    swap_count = 0
    for idx, s in enumerate(swap_flags):
        if s == 0:
            swap_count += swap_flags[:idx].count(1)

    print "Case #%d: %d" % (cn, swap_count)


def main():
    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    tc = r.readline()
    for cn in range(1, int(tc) + 1):
        nkbt = map(int, r.readline().strip().split(' '))
        ns = map(int, r.readline().strip().split(' '))
        vs = map(int, r.readline().strip().split(' '))

        solve_case(nkbt[1], nkbt[2], nkbt[3], ns, vs, cn)


if __name__ == '__main__':
    main()
