require 'pp'

casecount = 0
cases = []

def dp(param)
	#pp param
end


open( ARGV[0] ) {|f|
	casecount = f.gets.to_i
	casecount.times {
		count = f.gets.split(' ').map(&:to_i)
		dp count
		existspath = {}
		count[0].times {
			path = f.gets.strip
			path.slice!(0)
			path = path.split('/')
			nowpath = existspath
			path.each{|dir|
				nowpath[dir] = {} if !nowpath.include?(dir)
				nowpath = nowpath[dir]
			}
		}
		mkpath = []
		count[1].times {
			path = f.gets.strip
			path.slice!(0)
			path = path.split('/')
			mkpath.push path
		}
		cases.push([existspath, mkpath])
	}
}

def solve(c)
	count = 0
	existspath = c[0]
	mkpath = c[1]
	mkpath.each{|path|
		nowpath = existspath
		dp nowpath
		path.each{|dir|
			dp dir
			if !nowpath.include?(dir)
				dp '!!!'
				count += 1
				nowpath[dir] = {}
			end
			nowpath = nowpath[dir]
		}
	}

	count
end

i = 1
cases.each{|c|
	ans = solve(c)
	puts "Case ##{i}: #{ans}"
	dp "========="

	i += 1
}
