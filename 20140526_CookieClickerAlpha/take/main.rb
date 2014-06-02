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
  farm_cost = c[0]
  farm_production = c[1]
  goal = c[2]

  last_farm_count = 0
  farm_count = 0
  time = 0.0
  ot = Float::MAX
  lastT = 0.0

  while true
    while true
      if farm_count >= last_farm_count
        tmp = goal / (2 + farm_production * farm_count)
        time += tmp
        break
      else
        tmp = farm_cost / (2 + farm_production * farm_count)
        farm_count += 1
        time += tmp
        lastT = time
      end
    end

    if time < ot
      ot = time
      last_farm_count += 1
      time = lastT
    else
      time = ot
      break
    end
  end

  puts "Case ##{i}: " + sprintf("%.07f", time)
}
