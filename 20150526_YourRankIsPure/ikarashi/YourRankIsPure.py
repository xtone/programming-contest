#!/usr/bin/python
import sys
import itertools

def check(array,x):
	while True:
		if x in array:
			x = array.index(x)
			x += 1
			if x == 1:
				return 1
		else:
			return 0
def solve(x):
	arrayData = []
	for num in range(2,int(x)):
		arrayData.append(num)
	ans = 0
	array_len = len(arrayData)
	while array_len > 0:
		for element in itertools.combinations(arrayData,array_len):
			ans += check(element,len(element)+1)
		array_len -= 1
	ans += 1
	return ans %100003
	
argvs = sys.argv
argc = len(argvs)
fp = open(argvs[1], 'r')
count = int(fp.readline())
for no in range(1,count + 1):
	print "Case #" + str(no) + ": " + str(solve(fp.readline()))
fp.close()
