casecount = 0
cases = []


open( ARGV[0] ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    c = []

    2.times{
      ans = f.gets.to_i
      4.times {|t|
        if t == ans - 1
          c.push(f.gets.split(' ').map{|s| s.to_i })
        else
          f.gets # 不要
        end
      }
    }

    cases.push(c)
  }
}

i = 0
cases.each {|c|
  i += 1
  a = c[0] & c[1]

  if a.length == 1
    puts "Case ##{i}: #{a[0]}"
  elsif a.length > 1
    puts "Case ##{i}: Bad magician!"
  else
    puts "Case ##{i}: Volunteer cheated!"
  end
}
