import sys


def calculate_score(shuffled, m, score_list):
    score = 0
    for i in range(1000):
        s = m[i][shuffled[i]]
        score += s - 1000

    score_list.append(score)


def main():
    m_file = open('map.txt', 'r')
    m = []
    for line in m_file:
        m.append(map(int, line.strip().split(' ')))

    r = sys.stdin

    if len(sys.argv) > 1:
        r = open(sys.argv[1], 'r')

    total_cases = r.readline()
    score_list = []
    for case_number in range(1, int(total_cases) + 1):
        n = int(r.readline())
        a = map(int, r.readline().strip().split(' '))
        calculate_score(a, m, score_list)

    average = sum(score_list) / len(score_list)
    for i, score in enumerate(score_list):
        case_number = i + 1
        if score > average:
            print "Case #%d: BAD" % case_number
        else:
            print "Case #%d: GOOD" % case_number


main()
