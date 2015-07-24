require 'pp'

casecount = 0
cases = []
MEMO = {}
CMEMO = {}

def dp(params)
	#pp params
end

open( ARGV[0] ) {|f|
	casecount = f.gets.to_i
	casecount.times {
		unit, n = f.gets.strip.split(' ').map(&:to_i)
		grids = [] 
		unit.times {
			grids << f.gets.strip.split('')
		}
		cases.push [n, grids]
	}
}

def _check(grids, n)
	ans = 0
	l = grids.length
	l.times {|i|
		l.times {|j|
			target = grids[i][j]
			next if target == '.'
			# 右
			f = true
			(n-1).times {|k|
				if j+k+1 >= l || target != grids[i][j+k+1]
					f = false
					break
				end
			}
			ans |= target == 'R' ? 1 : 2 if f
			
			# 下
			f = true
			(n-1).times {|k|
				if i+k+1 >= l
					f = false
					break
				end
				if i+k+1 >= l || target != grids[i+k+1][j]
					f = false
					break
				end
			}
			ans |= target == 'R' ? 1 : 2 if f
				
			# 右下
			f = true
			(n-1).times {|k|
				if i+k+1 >= l || j+k+1 >= l || target != grids[i+k+1][j+k+1]
					f = false
					break
				end
			}
			ans |= target == 'R' ? 1 : 2 if f
				
			# 左下
			f = true
			(n-1).times {|k|
				if j-k-1 < 0 || i+k+1 >= l || target != grids[i+k+1][j-k-1]
					f = false
					break
				end
			}
			ans |= target == 'R' ? 1 : 2 if f
		}
	}
	return ans
end

def _rotation(grids)
	n = grids.length
	new_grids = Marshal.load(Marshal.dump(grids))
	# 右
	n.times {|i|
		tmp = new_grids[i].join('').gsub('.', '')
		new_grids[i] = (('.' * (n - tmp.length)) + tmp).split('')
	}
	new_grids = new_grids.transpose
	new_grids.each{|l|
		l.reverse!
	}
	dp new_grids
	return new_grids
end

def solve(c)
	n, grids = c
	dp grids
	ans = _check(grids, n)
	ans |= _check(_rotation(grids), n)
	
	case ans
	when 1
		return 'Red'
	when 2
		return 'Blue'
	when 3
		return 'Both'
	else
		return 'Neither'
	end
end

i = 1

cases.each{|c|
	ans = solve(c)
	puts "Case ##{i}: #{ans}"
	dp "======"
	
	i += 1
}