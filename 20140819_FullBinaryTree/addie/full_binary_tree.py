import sys

import networkx


def is_full_binary_tree(g):
    if not networkx.is_connected(g):
        return False

    root_found = False
    for n in networkx.nodes(g):
        neighbors = len(list(networkx.all_neighbors(g, n)))
        # 2 neighbors node should be root.
        # Thus, this node appears only once per tree.
        if neighbors == 2 and not root_found:
            root_found = True
            continue

        if not (neighbors == 1 or neighbors == 3):
            return False

    return True


def find_root_nodes(g):
    nodes = []
    for n in networkx.nodes(g):
        neighbors = len(list(networkx.all_neighbors(g, n)))
        if neighbors > 1:
            nodes.append(n)

    return nodes


CUT_CACHE = {}


def cut(g, p, n):
    global CUT_CACHE
    if (p, n) in CUT_CACHE:
        return CUT_CACHE[(p, n)]

    neighbors = list(networkx.all_neighbors(g, n))
    while p in neighbors:
        neighbors.remove(p)

    cost = 1
    for neighbor in neighbors:
        cost += cut(g, n, neighbor)
    CUT_CACHE[(p, n)] = cost
    return cost


PROCESS_CACHE = {}


def process(g, p, n):
    global PROCESS_CACHE

    if (p, n) in PROCESS_CACHE:
        return PROCESS_CACHE[(p, n)]

    neighbors = list(networkx.all_neighbors(g, n))
    while p in neighbors:
        neighbors.remove(p)

    neighbor_count = len(neighbors)
    ret = 0
    if neighbor_count == 0:
        pass
    elif neighbor_count == 1:
        ret = cut(g, n, neighbors[0])
    elif neighbor_count == 2:
        ret = process(g, n, neighbors[0]) + process(g, n, neighbors[1])
    else:  # neighbor_count > 2
        cut_costs = []
        for i in range(0, neighbor_count):
            cut_costs.append((cut(g, n, neighbors[i]), neighbors[i]))
        process_costs = []
        for i in range(0, neighbor_count):
            process_costs.append(process(g, n, neighbors[i]))

        # Select best 2 processes, rests are cuts.
        costs = map(lambda (a, b): (b - a[0], a[0], b), zip(cut_costs, process_costs))
        costs.sort(key=lambda a: a[0])
        ret = sum([c[1] for c in costs[2:]]) + sum(c[2] for c in costs[:2])

    PROCESS_CACHE[(p, n)] = ret
    return ret


def solve_case(g, case_number):
    global CUT_CACHE, PROCESS_CACHE
    PROCESS_CACHE.clear()
    CUT_CACHE.clear()
    roots = find_root_nodes(g)
    counts = []
    for r in roots:
        proc = process(g, r, r)
        counts.append(proc)

    # Special case. Tree may have only two nodes...
    if len(counts) == 0:
        counts.append(1)

    print "Case #%d: %d" % (case_number, min(counts))


def main():
    sys.setrecursionlimit(2000)

    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    for case_number in range(1, int(total_cases) + 1):
        n = int(r.readline())
        g = networkx.Graph()
        for i in range(0, (n - 1)):
            xy = map(int, r.readline().split(' '))
            g.add_edge(xy[0], xy[1])
        solve_case(g, case_number)


main()
