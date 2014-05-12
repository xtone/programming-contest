# !/usr/bin/python
import sys
import math


def shorten_car(car):
    prev = ''
    new_car = ""
    for c in car:
        if c == prev:
            continue
        else:
            prev = c
            new_car += c
    return new_car


def connect_cars(cars):
    index = 0
    scale = 1
    new_cars = sorted(cars, key=lambda c: len(c))
    same_count = {}

    while index < len(new_cars):
        car = new_cars[index]
        other_cars = new_cars[:]
        other_cars.remove(car)
        if len(car) == 1:
            if not car in same_count:
                same_count[car] = 1
            for o_car in other_cars:
                if o_car[0] == car or o_car[-1] == car:
                    if len(o_car) == 1:
                        same_count[car] += 1
                    new_cars.pop(index)
                    break
            else:
                index += 1
        else:
            head = car[0]
            tail = car[-1]
            for o_car in other_cars:
                if o_car[-1] == head:
                    if len(o_car) == 1:
                        if not o_car in same_count:
                            same_count[o_car] = 1
                        else:
                            same_count[o_car] += 1
                    new_cars.pop(index)
                    new_cars[new_cars.index(o_car)] += car[1:]
                    break
                if o_car[0] == tail:
                    if len(o_car) == 1:
                        if not o_car in same_count:
                            same_count[o_car] = 1
                        else:
                            same_count[o_car] += 1
                    new_cars.pop(index)
                    new_cars[new_cars.index(o_car)] = car + o_car[1:]
                    break
            else:
                index += 1
    for count in same_count.values():
        scale *= math.factorial(count)
    return new_cars, scale


def is_valid_cars(cars):
    occured = []
    prev = ''
    for c in list(cars):
        if c == prev:
            continue
        if c != prev and not c in occured:
            occured.append(c)
            prev = c
            continue
        return False
    return True


# solve case function
def solve_case(cars, case_number):
    new_cars, scale = connect_cars(cars)
    cars = new_cars
    cars_str = "".join(cars)
    if len(cars_str) != len(set(cars_str)):
        print "Case #%d: 0" % case_number
        return
    print "Case #%d: %d" % (case_number, (math.factorial(len(cars)) * scale) % 1000000007)

# main
r = sys.stdin

if len(sys.argv) > 1:
    r = open(sys.argv[1], 'r')

total_cases = r.readline()
for case_number in range(1, int(total_cases) + 1):
    r.readline()
    cs = map(shorten_car, r.readline().strip().split(' '))
    solve_case(cs, case_number)
