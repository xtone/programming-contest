require 'pp'

casecount = 0
cases = []


open( "./A-large-practice.in" ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    c = []
    count = f.gets.to_i
    count.times{
      c.push(f.gets.strip)
    }
    cases.push(c)
  }
}

def f(a)
  ret = []
  t = a[0]
  c = 1

  (1..a.length-1).each{|i|
    if t != a[i]
      ret.push(c)
      t = a[i]
      c = 1
    else
      c += 1
    end
  }

  ret.push(c)

  ret
end

def f2(a)
  a.sort!
  t = a[a.length/2]
  ans = 0
  a.each{|b|
    ans += (b - t).abs
  }
  ans
end


i = 0
cases.each {|c|
  i += 1
  ans = 0

  a = c.map{|s| s.squeeze }
  if a.uniq.length != 1
    puts "Case ##{i}: Fegla Won"
    next
  end

  c2 = []
  (0..c.length-1).each{|j|
    t = f(c[j])
    c2.push(t)
  }
  c3 = c2.transpose
  c3.each{|j|
    ans += f2(j)
  }

  puts "Case ##{i}: " + ans.to_s
}
