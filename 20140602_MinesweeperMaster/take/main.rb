require 'pp'
casecount = 0
cases = []

open( ARGV[0] ) {|f|
	casecount = f.gets.to_i
	casecount.times {
		cases.push(f.gets.split(' ').map{|s| s.to_i })
	}
}

def solve(r,c,m)
	cells = Array.new(r){Array.new(c){'.'}}

	# 地雷が無い場合はどこでもよい
	if m == 0
			cells[0][0] = 'c'
			return cells
	end

	# 1つ以外地雷の場合は全て埋めてどこか一つだけクリック
	if m == r * c - 1
			for i in 0..(r-1)
					for j in 0..(c-1)
							cells[i][j] = '*'
					end
			end
			cells[0][0] = 'c'
			return cells
	end

	# 一列の時は並べる
	if r == 1
		if m >= c - 1
			# pp 'aa0'
			return nil
		end
		(c-1).downto(c-1-m) do |j|
					cells[0][j] = '*'
			end
			cells[0][0] = 'c'
			return cells
	end

	if c == 1
		if m >= r - 1
			# pp 'aa1'
			return nil
		end
		(r-1).downto(r-1-m) do |j|
					cells[j][0] = '*'
			end
			cells[0][0] = 'c'
			return cells
	end

	# 一列以外の時は周りに3マス最低必要なのでそれ以外はエラー
	# if m >= r * c - 3
	# 		return nil
	# end

	# 地雷のない数
	s = r * c - m

	if r == 2
			# 奇数はだめ
			if m % 2 == 1 || s == 2
				# pp 'aa2'
				return nil
			end
			for i in 0..(r-1)
					for j in 0..( m / 2 - 1)
							cells[i][j] = '*'
					end
			end

			cells[0][c - 1] = 'c'
			return cells
	end

	if c == 2
			# 奇数はだめ
			if m % 2 == 1 || s == 2
				# pp 'aa4'
				return nil
			end
			for i in 0..(c-1)
					for j in 0..( m / 2 - 1)
							cells[j][i] = '*'
					end
			end

			cells[r-1][0] = 'c'
			return cells
	end

	# それ以外
	# 一端地雷で埋めて動ける範囲を作る
	cells = Array.new(r){Array.new(c){'*'}}
	pp 'a2'
	# 空きの数が4, 6, 8以上必要、それ以外はだめ
	if s == 2 || s == 3 || s == 5 || s == 7
		# pp 'aa5'
		return nil
	end

	for i in 0..(r-1)
		next if s == 3 # 一つ余ると条件を満たさない
		if s == 0
			cells[0][0] = 'c'
			return cells
		end
		cells[i][0] = '.'
		cells[i][1] = '.'
		s -= 2
	end

	for j in 2..(c-1)
		# 右端が1つになると開けなくなるので下に一つ残す
		if s == r + 1
			for i in 0..(r-2)
				cells[i][j] = '.'
			end
			cells[0][j+1] = '.'
			cells[1][j+1] = '.'
			cells[0][0] = 'c'
			return cells
		end
		for i in 0..(r-1)
			if s == 0
				cells[0][0] = 'c'
				return cells
			end
			cells[i][j] = '.'
			s -= 1
		end
	end

	# pp 'aa6'
	return nil
end

i = 0
cases.each{|d|
	i+=1

	r = d[0]
	c = d[1]
	m = d[2]

	puts "Case ##{i}:"
	cells = solve(r,c,m)

	if cells == nil
		puts "Impossible"
		next
	end

	cells.each {|row|
		puts row.join('')
	}
}
