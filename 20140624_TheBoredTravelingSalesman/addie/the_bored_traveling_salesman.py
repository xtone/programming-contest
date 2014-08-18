import sys

import networkx


class Ticket:
    def __init__(self, dep, des):
        self.dep = dep
        self.des = des

    def __eq__(self, other):
        return (self.dep, self.des) == (other.dep, other.des)


class City:
    def __init__(self, id, zip_code):
        self.id = id
        self.zip_code = zip_code

    def __eq__(self, other):
        return self.id == other.id


def solve_case(cs, ts, case_number):
    cs.sort(key=lambda city: city.zip_code)
    current_city = cs.pop(0)
    result = current_city.zip_code
    visited_cities = []

    while len(cs) > 0:
        visited_cities.append(current_city)
        neighbors = set([n for n in networkx.all_neighbors(ts, current_city.id)])
        anc_check_ts = ts.copy()
        anc_neighbors = []
        child = -1
        for anc in reversed(visited_cities):
            if child < 0:
                child = anc.id
                continue
            anc_check_ts.remove_node(child)
            if networkx.is_connected(anc_check_ts):
                anc_neighbors.append(set(n for n in networkx.all_neighbors(anc_check_ts, anc.id)))
            else:
                break

            child = anc.id

        for city in cs:
            if city.id in neighbors:
                result += city.zip_code
                current_city = city
                cs.remove(current_city)
                break

            count = 0
            found = False
            for a_neighbors in anc_neighbors:
                count += 1
                if city.id in a_neighbors:
                    found = True
                    result += city.zip_code
                    for i in range(0, count):
                        cur = visited_cities.pop()
                        ts.remove_node(cur.id)

                    current_city = city
                    cs.remove(current_city)
                    break
            if found:
                break

        else:
            ts.remove_node(visited_cities.pop().id)
            current_city = visited_cities.pop()

    print "Case #%d: %s" % (case_number, result)

# main
r = sys.stdin

if len(sys.argv) > 1:
    r = open(sys.argv[1], 'r')

total_cases = r.readline()
for case_number in range(1, int(total_cases) + 1):
    nm = map(int, r.readline().split(' '))
    cs = []
    ts = networkx.Graph()
    for i in range(0, nm[0]):
        cs.append(City(i + 1, r.readline().strip()))
    for i in range(0, nm[1]):
        t = map(int, r.readline().split(' '))
        ts.add_edge(t[0], t[1])
    solve_case(cs, ts, case_number)
