casecount = 0
cases = []


open( ARGV[0] ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    cases.push(f.gets.split(' ').map{|s| s.to_f })
  }
}

i = 0
cases.each{|c|
  i+=1
  factory_cost = c[0]
  factory_production = c[1]
  goal = c[2]

  fc = 0
  factory_count = 0
  time = 0.0
  ot = Float::MAX
  lastT = 0.0

  while true
    while true
      if factory_count >= fc
        tmp = goal / (2 + factory_production * factory_count)
        time += tmp
        break
      else
        tmp = factory_cost / (2 + factory_production * factory_count)
        factory_count += 1
        time += tmp
        lastT = time
      end
    end

    if time < ot
      ot = time
      fc += 1
      time = lastT
    else
      time = ot
      break
    end
  end

  puts "Case ##{i}: " + sprintf("%.07f", time)
}
