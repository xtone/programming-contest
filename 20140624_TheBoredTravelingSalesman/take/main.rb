require 'pp'

casecount = 0
cases = []
$zips = []
$node = []
$stack = []
$ans = []


open( ARGV[0] ) {|f|
  casecount = f.gets.to_i
  casecount.times {
    zips = []
    counts = f.gets.split(' ').map{|s| s.to_i }
    counts[0].times{
      zips.push(f.gets.strip)
    }
    sorted_zips = zips.sort
    links = []
    counts[1].times{
      t2 = f.gets.split(' ').map{|s| s.to_i }
      links.push(t2)
    }
    node = Array.new(zips.count, 0)
    links.each{|l|
      s1 = l[0] - 1
      s2 = l[1] - 1

      d1 = sorted_zips.find_index(zips[s1])
      d2 = sorted_zips.find_index(zips[s2])

      node[d1] |= 1 << (d2)
      node[d2] |= 1 << (d1)
    }
    cases.push([sorted_zips,node])
  }
}

def traveling(arrivals, i)
  $stack.push(i)
  $ans.push($zips[i])
  arrivals |= 1 << i

  next_i = 0
  while next_i <= $zips.count
    if (arrivals & (1 << next_i)) == 0
      # まだ到達していない都市
      if ($node[i] & (1 << next_i)) > 0
        # 移動可能
        arrivals = traveling(arrivals, next_i)
        # 最初から走査をやり直す
        next_i = 0
        next
      else
        # 最小移動できない
        # 今まで移動してきた都市から移動できるか走査する
        tmp = arrivals
        (0..$stack.count-1).each{|j|
          check_node = []
          check_node.push($stack[j])
          while check_node.count > 0
            c = check_node.pop
            (0..$zips.count-1).each{|k|
              if (($node[c] & (1<<k))!=0) && ((tmp & (1<<k)) == 0) # 未到達で移動可能
                tmp |= 1 << k
                check_node.push(k)
              end
            }
          end

          if (tmp == (1 << $zips.count) - 1) && (($node[$stack[j]] & (1 << next_i)) != 0)
            # 全ての都市をまわっていて その都市から進める場合
            # この先を進むの止めて戻る
            $stack.pop
            return arrivals
          end
        }
      end
    end
    next_i += 1
  end

  return arrivals
end

case_index = 0
cases.each {|c|
  case_index += 1
  ans = []

  $zips = c[0]
  $node = c[1]
  $stack = []
  $ans = []

  traveling(0, 0)
  puts "Case ##{case_index}: " + $ans.join('')
}
