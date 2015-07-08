require 'pp'

casecount = 0
cases = []
MEMO = {}
CMEMO = {}

def dp(params)
	#pp params
end

class Integer
  def combination(k)
    self.factorial / (k.factorial * (self-k).factorial)
  end

  def permutation(k)
    self.factorial / (self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

open( ARGV[0] ) {|f|
	casecount = f.gets.to_i
	casecount.times {
		cases.push f.gets.to_i
	}
}

def _solve(n, t)
	return 1 if n <= t || t-2 <= 0
	key = "#{n}_#{t}"
	return MEMO[key] if MEMO.include?(key)
	ans = 0
	for m in (0..t-2)
		dp [n, t, m]
		c = n-t-1
		break if c < m
		ckey = "#{c}_#{m}"
		CMEMO[ckey] = c.combination(m) if !CMEMO.include?(ckey)
		a = CMEMO[ckey] * _solve(t, t-m-1)
		dp ["_solve", a]
		ans += a
	end
	MEMO[key] = ans
	ans
end

def solve(n)
	return 1 if n == 1 || n == 2

	ans = 0
	ans += 2 # @1, 2は1パターンのみ
	
	for t in (3..n-1) do
		ans += _solve(n, t)
	end
	ans % 100003
end

i = 1

cases.each{|c|
	ans = solve(c)
	puts "Case ##{i}: #{ans}"
	dp "======"
	
	i += 1
}