import sys
import networkx


def solve_case(exists, wanted, case_number):
    directory_graph = networkx.DiGraph()

    mkdir_count = 0

    for directory in exists:
        paths = directory.split('/')
        previous_path = None
        path = ""
        for p in paths:
            if path == "/":
                path = path + p
            else:
                path = path + "/" + p
            if previous_path:
                directory_graph.add_path([previous_path, path])
            previous_path = path

    for directory in wanted:
        paths = directory.split('/')
        previous_path = None
        path = ""
        for p in paths:
            if path == "/":
                path = path + p
            else:
                path = path + "/" + p
            if previous_path:
                if not directory_graph.has_edge(previous_path, path):
                    directory_graph.add_path([previous_path, path])
                    mkdir_count += 1
            previous_path = path

    print "Case #%d: %d" % (case_number, mkdir_count)


def main():
    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    for case_number in range(1, int(total_cases) + 1):
        ew = map(int, r.readline().strip().split(' '))
        exists = []
        wanted = []
        for i in range(0, ew[0]):
            exists.append(r.readline().strip())

        for i in range(0, ew[1]):
            wanted.append(r.readline().strip())

        solve_case(exists, wanted, case_number)


if __name__ == '__main__':
    main()