#!/usr/bin/python
import sys
import itertools

def check(array,x):
	checkFlag = False
	while checkFlag == False:
		if x in array:
			x = array.index(x)
			x += 1
			if x == 1:
				checkFlag = True
				break
		else:
			break
	if checkFlag:
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
	return ans % 100003
	
argvs = sys.argv
argc = len(argvs)

fp = open(argvs[1], 'r')
count = 0
for line in fp.readlines():
	if count != 0:
		result = solve(line.strip())
		print "Case #" + str(count) + ": " + str(result)
	count += 1
fp.close()
