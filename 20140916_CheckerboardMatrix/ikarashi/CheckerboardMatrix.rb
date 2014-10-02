def view(count, arr)
	countZero=0
	countOne=0
	check=TRUE
	lengthArray=Array.new(arr[0].size-1,"")
	sortArray=Array.new(arr[0].size-1).map{Array.new(arr.size,'')}
	count=0
	for id in arr do
		arraySize=id.size-2
		for num in 0..arraySize
			sortArray[count][num]=id[num]
			lengthArray[num]+=id[num]
		end
		countZero = id.scan(/0/).size
		countOne  = id.scan(/1/).size
		
		
		unless countZero==(id.size/2)
			check=FALSE
		end
		unless countOne==(id.size/2)
			check=FALSE	
		end
		count+=1
	end
	for char in lengthArray do
		countZero = char.scan(/0/).size
		countOne  = char.scan(/1/).size

		unless countZero==(char.size/2)
			check=FALSE
	        end
	       	unless countOne==(char.size/2)
			check=FALSE
		end
	end
	if check==TRUE
		check1=""
		check2=""
		c1_num=0
		c2_num=0
		lineArr=[]
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
					c1_num+=1
					lineArr.push(1)
				else
					if check2 != ""
						if check2==id
							c2_num+=1
							lineArr.push(2)	
						else
							return 3
						end
					end
				end
			end
		end
		if c1_num!=arr.size/2 && c2_num!=arr.size/2
			return 3
		end
		for id in arr
			if id.scan(/01/).size==id.size/2
			elsif id.scan(/10/).size==id.size/2
			else
				check=FALSE
			end
		end
		for id in lengthArray do
			
			if id.scan(/01/).size==id.size/2
			elsif id.scan(/10/).size==id.size/2
			else
				check=FALSE
			end
		end
		if check==TRUE
			return 1
		else
		      	#Sort対象
                	sortCount=0      
			a=0
                      	b=0
                      	c=0
                      	d=0
                      	for num in 0..lineArr.size do
				if lineArr[num]==1
					if num % 2 ==0
                        			a+=1
                       	 		else
                       	 			b+=1
                       		 	end
                        	elsif lineArr[num]==2
                        		if num % 2 ==0
                                		c+=1
                                	else
                                		d+=1
                        	        end
                        	end
			end
			if a==b
				sortCount=a
			elsif a > b
				sortCount=b	
			else
				sortCount=a
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

#		print argv
#		result = sprintf "%.7f", check(argv.split.map(&:to_f))
#		print "Case #" + (ARGF.file.lineno - 1).to_s + ": " + result + "\n" 
	end
end
#print "OK:" + c_ok.to_s + " Sort:" + sort.to_s + " NG:" + impossible.to_s + "\n"
