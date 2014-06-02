require 'pp'

casecount = 0
cases = []


open( ARGV[0] ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    cases.push(f.gets.split(' ').map{|s| s.to_i })
  }
}

def solve(n, m, k)
  ret = k
	for a in (2..n+1)
    for b in (a..m+1)
      if a * b <= k
        break
      end
      c = a * b
      for s in (1..b * 2)
        c -= (s / 4).floor + 1
        #pp ['*', ((s / 4).floor + 1), c]
        break if c < k
        #pp [a, b, c, s]
        ret = [ret, (a * 2 + b * 2 - 4 - s)].min
        #pp ['a', ret, (a * 2 + b * 2 - 4 - s), s]
      end
    end
  end

  ret
end

i = 0
cases.each {|c|
  i += 1

	n, m, k = c
	n, m = m, n if n > m
	ans = 0
	#pp [n, m, k]

	if k <= 6 || n < 3 || m < 3
		ans = k
	else
		ans = solve(n, m, k)
	end

  puts "Case ##{i}: #{ans}"
}
