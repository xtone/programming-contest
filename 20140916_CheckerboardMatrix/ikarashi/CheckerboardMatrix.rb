def view(count, arr)
	countZero=0
	countOne=0
	check=TRUE
	lengthArray=Array.new(arr[0].size-1,"")
	sortArray=Array.new(arr[0].size-1).map{Array.new(arr.size,'')}
	count=0
	checkSort=FALSE
	first_even=0
	first_odd=0
	
	#Sort対象
	check1=""
	check2=""
	ch1_num=0
	ch2_num=0
	for id in arr do
		if check1 == ""
			check1=id
		elsif check2 == ""
			if check1!=id
				check2=id
			end
		end
		if check1 != ""
			if check1==id
				ch1_num+=1
			else
				if check2 != ""
					if check2==id
						ch2_num+=1
					else
						return 3
					end
				end
			end
		end
	end
	if ch1_num!=ch2_num 
		return 3
	end
	
	for id in arr do
		arraySize=id.size-2
		for num in 0..arraySize
			if num==0
				sortArray[num][count]=id[num]
			end
			lengthArray[num]+=id[num]
			if count==0
				if id[num]=="0"
					if num%2==0
						first_even+=1
					else
						first_odd+=1
					end
				end
			end
		end
		countZero = id.scan(/0/).size
		countOne  = id.scan(/1/).size
		
		
		unless countZero==(id.size/2)
			check=FALSE
			return 3
		end
		unless countOne==(id.size/2)
			check=FALSE
			return 3
		end
		if id.scan(/01/).size == id.size/2
		elsif id.scan(/10/).size == id.size/2
		else
			checkSort=TRUE
		end
		count+=1
	end
	
	count=0
	for char in lengthArray do
		countZero = char.scan(/0/).size
		countOne  = char.scan(/1/).size

		unless countZero==(char.size/2)
			check=FALSE
			return 3
		end
		unless countOne==(char.size/2)
			check=FALSE
			return 3
		end
		count+=1
	end
	if check==TRUE
		for id in arr do
			if id.scan(/01/).size == id.size/2
			elsif id.scan(/10/).size == id.size/2
			else
				check=FALSE
				break
			end
		end
		for char in lengthArray do
			if char.scan(/01/).size == char.size/2
			elsif char.scan(/10/).size == char.size/2
			else
				check=FALSE
				break
			end
		end
		if check==TRUE
			return 1
		else
			sortCount=0
			if first_even==first_odd
				sortCount=first_even
			elsif first_even > first_odd
				sortCount=first_odd
			else
				sortCount=first_even
			end
			e=0
			f=0
			g=0
			h=0
			for num in 0..sortArray[0].size do
				if sortArray[0][num]=="0"
					if num % 2==0
						e+=1
					else
						f+=1
					end
				elsif sortArray[0][num]=="1"
					if num % 2==0
						g+=1
					else
						h+=1
					end
				end
			end
			if e==f
				sortCount+=e
			elsif e > f
				sortCount+=f
			else
				sortCount+=e
			end
#			print first_even.to_s + " " + first_odd.to_s + "e=" + e.to_s + "f= " + f.to_s + "g= " + g.to_s + "h= " + h.to_s
			sortCount+=10
			return sortCount
		end
	else
		return 3
	end
end

pCount=0
pLineCount=0
problemCount=0
pArr=[]
c_ok=0
sort=0
impossible=0
while argv = ARGF.gets
	if ARGF.file.lineno != 1
		if pLineCount==0 then
			problemCount=argv.to_i
			pLineCount+=1
		else
			pArr[pLineCount-1]=argv
			pLineCount+=1
			if pLineCount>(problemCount*2)
				pLineCount=0
				result=view(pCount,pArr)		
				pCount+=1
				if result==1
					c_ok+=1
					print "Case #" + pCount.to_s + ": 0" + "\n" 
				elsif result==3
					impossible+=1
					print "Case #" + pCount.to_s + ": IMPOSSIBLE" + "\n" 
				else
					sort+=1
					result-=10
					print "Case #" + pCount.to_s + ": " + result.to_s  + "\n" 
				end
				pArr=[]
			end	
		end
	end
end
