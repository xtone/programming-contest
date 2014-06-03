require 'pp'

casecount = 0
cases = []


open( ARGV[0] ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    cases.push(f.gets.split('/').map{|s| s.to_i })
  }
}

i = 0
cases.each {|c|
  i += 1
  ans = 1

  if c[1] % 2 != 0
    puts "Case ##{i}: impossible"
    next
  end

  a = Rational(c[0], c[1])
  flag = false
  40.times {
    a *= 2
    if a >= 1
      a -= 1
      if a == 0
        break
      end
      flag = true
    else
      ans += 1 if !flag
    end
  }

  if a > 0
    puts "Case ##{i}: impossible"
  else
    puts "Case ##{i}: " + ans.to_s
  end
}
