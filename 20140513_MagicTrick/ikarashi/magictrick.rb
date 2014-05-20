def checkArry(m,n)
	#p m,n
	m.sort
	n.sort
	if m == n
		retrun "Bad magician!"
	end 
	s = m - n
	if s.size == 3
		r = m - s 
		return r[0]
	elsif s.size == 4
		return "Volunteer cheated!"
	else
		return "Bad magician!"
	end
	
end

questionCount = 1
getPosition = 0
getOneData = []
getTwoData = []
while argv = ARGF.gets
	if ARGF.file.lineno != 1
		questionLineNo = (ARGF.file.lineno - 1)%10 
		case questionLineNo 
		when 1,6
			getPosition = argv.to_i
		when 2..5
			if (getPosition+1) == questionLineNo
				getOneData = argv.split(" ")
			end
		when 0,7,8,9
			replaceLineNo = 0
			case questionLineNo
			when 7	
				replaceLineNo = 1
			when 8
                                replaceLineNo = 2
                        when 9
                                replaceLineNo = 3
                        when 0
                                replaceLineNo = 4
			end
			if getPosition == replaceLineNo
                                getTwoData = argv.split(" ")
			end 
		end
		if questionLineNo == 0
			result = checkArry(getOneData,getTwoData)	
			print "Case #" + questionCount.to_s + ":" + result + "\n"
			#p getOneData,getTwoData
			questionCount += 1
		end
	end
end
