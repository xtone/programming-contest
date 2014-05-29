def calcTimeOfBuyCoockieFarm( p,pc,cFc )
	buyTime=0
	pcc=2
	for num in 1..cFc
		buyTime+=p/pcc
		pcc+=pc		
	end
	return buyTime
end

def check(arr)
	priceCookieFarm=arr[0]
	produceCookiePerSecond=arr[1]
	clearCookieCount=arr[2]
	cookieFarmCount=0
	second=0
	if (priceCookieFarm/2) > clearCookieCount
		return second=clearCookieCount/2
	end	
	 
	perRate = 2
	
	count =(clearCookieCount / priceCookieFarm) - 1 
	
	for num in 1..count
		perRate +=produceCookiePerSecond
	end
	second = clearCookieCount/perRate
	cookieFarmCount = cookieFarmCount + count - 1

	second += calcTimeOfBuyCoockieFarm(priceCookieFarm,produceCookiePerSecond,cookieFarmCount)
	
	return second
end
while argv = ARGF.gets
	if ARGF.file.lineno != 1
		result = sprintf "%.7f", check(argv.split.map(&:to_f))
		print "Case #" + (ARGF.file.lineno - 1).to_s + ": " + result + "\n" 
	end
end
