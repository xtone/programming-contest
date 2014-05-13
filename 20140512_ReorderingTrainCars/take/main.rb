require 'pp'

casecount = 0
cases = []


open( "./B-large-practice.in" ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    f.gets
    cases.push(f.gets.split(' '))
  }
}

def fact(n)
  (1..n).to_a.inject(1){|r, i| r * i}
end

l = 0
cases.each {|c|
  c = c.map{|s| s.squeeze }
  # pp c
  c.sort!

  l += 1
  err = false

  kk = 1
  ct = c.map{|s| s.squeeze }

  ck = Hash.new(0)
  ct.each{|cc|
    if cc.length == 1
      ck[cc] += 1
    end
  }

  ck.each{|k,v|
    kk *= fact(v)
  }

  while true
    i = 0
    f = false
    while i < c.length
      j = 0
      while j < c.length
        if i != j
          if c[i][-1] == c[j][0]
            t1 = c[i]
            t2 = c[j]
            c.delete(t1)
            c.delete(t2)
            t1 += t2
            t1.squeeze!
            c.push(t1)
            f = true
            break
          end
        end
        j += 1
      end
      break if f
      i += 1
    end
    c.sort!
    break if !f
  end

  ans = 0
  cc = c.join('').split('')
  cc.sort!
  if cc.length == cc.uniq.length
    ans = (fact(c.length) * kk)% 1000000007
  end

  # pp c

  puts "Case ##{l}: " + ans.to_s
}
