def view(count, arr)
	nomad_data=[]
	#部族リスト作成
	for line in arr do
		line.slice!("\n")
		data = line.split(/ /)
		
		data = data.map{ |item| item.to_i() }
		for i in 1..data[1] do
			attack = []
			attack.push( data[0] + ( data[5] * ( i - 1 ) ) )
			attack.push( data[2] + ( data[6] * ( i - 1 ) ) )
			attack.push( data[3] + ( data[6] * ( i - 1 ) ) )
			attack.push( data[4] + ( data[7] * ( i - 1 ) ) )
			nomad_data.push( attack )
		end
	end
	nomad_data.sort_by! { |nomad| nomad[0] }
	
	#for nomad in nomad_data do
	#	p nomad.to_s + "\n"
	#end
	p_count = 0
	s_count = 0
	check_flag = false
	wall = Hash.new()
	changeWall = Hash.new()
	before = -1
	for nomad in 0...nomad_data.size do
		#p nomad_data[nomad].to_s
		if nomad == 0 then
			for num in nomad_data[nomad][1]...nomad_data[nomad][2] do
				changeWall[num] = nomad_data[nomad][3]
			end
			s_count += 1
			before = nomad_data[nomad][0]
			next
		end
		if before < nomad_data[nomad][0] then
			wall.merge!( changeWall )
			changeWall = Hash.new()
		end	
		check_flag = false
#		wall[nomad]=nomad_data[nomad]
		for pos in nomad_data[nomad][1]...nomad_data[nomad][2] do
			if wall[pos] then
				if wall[pos] < nomad_data[nomad][3] then
					if before < nomad_data[nomad][0] then
						changeWall[pos] = nomad_data[nomad][3]
					else
						if changeWall[pos] then
							if changeWall[pos] < nomad_data[nomad][3] then
								changeWall[pos] = nomad_data[nomad][3]
							end
						else
							changeWall[pos] = nomad_data[nomad][3]
						end
					end
					check_flag = true
				end
				
			else
				#mirai = nomad + 1
				#if nomad_data[nomad+1] != nil && before < nomad_data[nomad+1][0] then
				if before < nomad_data[nomad][0] then
					wall[pos] = nomad_data[nomad][3]
				else
					if changeWall[pos] then
						if changeWall[pos] < nomad_data[nomad][3] then
							changeWall[pos] = nomad_data[nomad][3]
						end
					else
						changeWall[pos] = nomad_data[nomad][3]
					end
				end
				check_flag = true
			end
		end
		before = nomad_data[nomad][0]
		if check_flag then
			s_count += 1
		end
	end
	return s_count
end

pCount=0
pLineCount=0
problemCount=0
pArr=[]

while argv = ARGF.gets
	if ARGF.file.lineno != 1
		if pLineCount==0 then
			problemCount=argv.to_i
			pLineCount+=1
		else
			pArr[pLineCount-1]=argv
			pLineCount+=1
			if problemCount==pArr.count
				pLineCount=0
				pCount+=1
				result=view(pCount,pArr)
				print "Case #" + pCount.to_s + ": " + result.to_s + "\n"
				pArr=[]
			end	
		end
	end
end
