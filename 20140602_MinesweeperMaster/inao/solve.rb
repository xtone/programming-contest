# 縦, 横, 地雷数
def solve(r, c, m)
  no_mine = (r * c - m)
  # 0不要
  if no_mine == 1
    data = Array.new(r).map{Array.new(c, 9)}
    data[0][0] = 0
    return build_configuration(data)
  end

  create_configuration(r, c, m) do |data|
    if valid_configuration?(data, r, c)
      return build_configuration(data)
    end
  end

  false
end

DIRECTION = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
]

def valid_configuration?(data, r, c)
  unless data.any?{|line| line.include?(0) }
    return false
  end

  #puts data.map{|l| l.join(" ")}.join("\n")

  # TODO 全てのゼロが隣接すること

  r.times do |y|
    c.times do |x|
      cell = data[y][x]

      # 地雷とゼロは無視
      if cell == 9 || cell == 0
        next
      end

      flag = false
      DIRECTION.each do |direction|
        x_d = x + direction[0]
        y_d = y + direction[1]
        if x_d < 0 || y_d < 0 || x_d >= c || y_d >= r
          next
        end

        if data[y_d][x_d] == 0
          flag = true
          break
        end
      end

      next if flag

      # 1つも隣接の0がない
      return false
    end
  end

  true
end

# パターンを作る
def create_configuration(r, c, m, &block)
  line_patterns = []
  (2 ** c).times do |i|
    line_patterns << format("%0#{c}d", i.to_s(2)).split('').map do |j|
      j == '1' ? 9 : 0
    end
  end

  line_patterns.repeated_combination(r) do |data|
    if count_mines(data) == m
      block.call(count_each_mines(data, r, c))
    end
  end
end

# セルごとに隣接地雷数をカウント
def count_each_mines(data, r, c)
  result = Array.new(r).map{Array.new(c, 0)}

  r.times do |y|
    c.times do |x|

      # 地雷セル
      if data[y][x]  == 9
        result[y][x] = 9
        next
      end

      # 地雷なしセル
      DIRECTION.each do |direction|
        x_d = x + direction[0]
        y_d = y + direction[1]
        if x_d < 0 || y_d < 0 || x_d >= c || y_d >= r
          next
        end
        if data[y_d][x_d] == 9
          result[y][x] += 1
        end
      end
    end
  end

  result
end

# 総地雷数をカウント
def count_mines(data)
  result = 0
  data.each do |line|
    line.each do |cell|
      result += 1 if cell == 9
    end
  end
  result
end

def build_configuration(data)
  result = ''

  first_zero = true
  data.each do |line|
    line.each do |cell|
      if cell == 9
        result += '*'
      else
        if cell == 0 && first_zero
          result += 'c'
          first_zero = false
        else
          result += '.'
        end
      end
    end
    result += "\n"
  end

  result
end

f = open(ARGV[0])
number = f.gets.strip.to_i

number.times do |i|
  puts "Case ##{i + 1}:"
  case_data = f.gets.strip.split(' ').map(&:to_i)
  p case_data
  result = solve(*case_data)
  if result
    puts result
  else
    puts 'Impossible'
  end
end

