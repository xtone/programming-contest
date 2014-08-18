casecount = 0
cases = []


open( ARGV[0]) {|f|
  casecount = f.gets.to_i
  casecount.times {
    f.gets
    cases.push([
      f.gets.split(' ').map{|s| s.to_f },
      f.gets.split(' ').map{|s| s.to_f }
      ])
  }
}

def check(n, k)
  sc = 0
  n.each{|nc|
    chose = false
    k.each{|kc|
      if kc > nc
        k.delete(kc)
        chose = true
        break
      end
    }

    if !chose
      sc += 1
      k.shift
    end
  }
  sc
end

def check2(a)
  sc = 0
  while a.length > 0
    if a[0][1] == 'N'
      a.shift
      (a.length-1).downto(0) {|i|
        if a[i][1] == 'K'
          a.delete_at(i)
          break
        end
      }
    else
      a.shift
      0.upto(a.length-1) {|i|
        if a[i][1] == 'N'
          a.delete_at(i)
          sc += 1
          break
        end
      }
    end
  end

  sc
end

i = 0
cases.each{|c|
  i += 1
  nsc = 0
  dsc = 0

  n = c[0].clone
  n = n.sort
  k = c[1].clone
  k = k.sort

  nsc = check(n, k)

  k = c[1].clone
  k = k.sort
  a = []
  n.each {|b|
    a.push([b, 'N'])
  }
  k.each {|b|
    a.push([b, 'K'])
  }
  a.sort!{|rhs, lhs| rhs[0] <=> lhs[0] }

  dsc = check2(a)

  puts "Case ##{i}: #{dsc} #{nsc}"
}
