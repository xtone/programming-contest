class Enclosure
  def initialize(line, case_number)
    @case_number = case_number
    matches = /([0-9]+) ([0-9]+) ([0-9]+)/.match(line)
    @n = [matches[1].to_i, matches[2].to_i].min
    @m = [matches[1].to_i, matches[2].to_i].max
    @k = matches[3].to_i
    @result = 'unresolved'
  end

  def target(a, i, status)
    case status
      when :left_top
        x = i
        y = a - i
      when :left_bottom
        x = i
        y = @n - (a-i) - 1
      when :right_bottom
        x = @m - i -1
        y = @n - (a-i) - 1
      when :right_top
        x = @m - i -1
        y = a - i
    end
    [x, y]
  end

  def target2(step, i, status)
    case status
      when :top
        x_offset = i
        y_offset = -step + i
      when :right
        x_offset = step - i
        y_offset = i
      when :bottom
        x_offset = -i
        y_offset = step - i
      when :left
        x_offset = -step + i
        y_offset = -i
    end
    [x_offset, y_offset]
  end

  def solve
    if @n < 3 || @k <= 4 then
      @result = @k
    else
      #self.solve1
      #self.solve2
      self.solve3
    end

    puts "Case ##{@case_number}: #{@result}"
    #self.format
  end

  def solve1
    point_count = @n * @m
    empty = point_count - @k
    @grid = Array.new(point_count, :point)

    status = :left_top
    a = 0
    b = 0
    status_list = [:left_top, :left_bottom, :right_bottom, :right_top]
    status_index = 0

    # emtpy
    while empty > 0 do
      if b > a then
        b = 0
        status_index = (status_index + 1) % 4
        status = status_list[status_index]
        if status == :left_top
          a += 1
        end
      else
        for i in b..a do
          (x, y) = self.target(a, i, status)
          case self[x, y]
            when :point
              # puts "(a, i, status) = (#{a}, #{i}, #{status}), (x, y) = (#{x}, #{y})"
              self[x, y] = :empty
              empty -= 1
          end
        end
        b += 1
      end
    end
    # self.format
    @result = @k

    @n.times do |y|
      @m.times do |x|
        if self.enclosed?(x, y) then
          @result -= 1
        end
      end
    end
  end

  def solve2
    point_count = @n * @m
    @grid = Array.new(point_count, :empty)

    center_x = @m / 2
    center_y = @n / 2

    self[center_x, center_y] = :point
    score = 1
    step = 1

    status_list = [:top, :left, :bottom, :right]
    status_index = 0

    while true do
      step.times do |i|
        (offset_x, offset_y) = self.target2(step, i, status_list[status_index])
        if self[center_x + offset_x, center_y + offset_y] == :empty then
          self[center_x + offset_x, center_y + offset_y] = :point
          score += 1
          if score >= @k then
            break
          end
        end
      end
      if score >= @k then
        break
      end
      status_index = (status_index + 1) % 4
      if status_index == 0 then
        step += 1
      end
    end

    result = @k
    @n.times do |y|
      @m.times do |x|
        if self.enclosed?(x, y) then
          result -= 1
        end
      end
    end
    @result = result if @result > result
  end

  def solve3
    h = 3
    w = 3

    score = fill_diamond(h, w)
    # hxw
    while score <= @k
      if h == w && w < @m then
        next_w = w + 1
        next_h = h
      elsif h < w && h < @n then
        next_w = w
        next_h = h + 1
      elsif w < @m then
        next_w = w + 1
        next_h = h
      else
        break
      end
      next_score = fill_diamond(next_h, next_w)
      if next_score > @k then
        fill_diamond(h, w)
        break
      else
        h = next_h
        w = next_w
        score = next_score
      end
    end

    #self.format

    rest = @k - score

    status_list = [:left_bottom, :right_top, :left_top, :right_bottom]
    status_index = 0

    step = 1
    index = 0
    l_half = h % 2 == 0 ? h/2-1 : h/2
    r_half = h/2

    #puts "l_half: #{l_half}, r_half: #{r_half}, score: #{score}, rest: #{rest}"

    while rest > 0 do
      change_status = false
      case status_list[status_index]
        when :left_bottom
          x = index
          y = l_half + step + index
          unless y + 1 < h then
            change_status = true
          end
        when :right_top
          x = w - 1 - index
          y = r_half - step - index
          unless y - 1 >= 0 then
            change_status = true
          end
        when :left_top
          x = l_half - step - index
          y = index
          unless x - 1 >= 0 then
            change_status = true
          end
        when :right_bottom
          x = (w - 1 - l_half) + step + index
          y = h - 1 - index
          unless x + 1 < w then
            change_status = true
          end
      end
      #puts "(#{x}, #{y}) #{self[x, y]} to :point, status: #{status_list[status_index]}"
      self[x, y] = :point
      rest -= 1
      index += 1

      if change_status then
        index = 0
        status_index = (status_index + 1) % 4
        if status_index == 0 then
          step += 1
        end
      end
    end

    result = @k
    @n.times do |y|
      @m.times do |x|
        if self.enclosed?(x, y) then
          result -= 1
        end
      end
    end
    @result = result
  end

  def fill_diamond(h, w)
    @grid = Array.new(@n * @m, :empty)
    score = 0
    l_half = h % 2 == 0 ? h/2 - 1 : h/2
    r_half = h / 2

    h.times do |y|
      w.times do |x|
        if x >= (l_half - y).abs && x <= (w - (r_half - y).abs - 1)
          self[x, y] = :point
          score += 1
        end
      end
    end
    score
  end

  def enclosed?(x, y)
    self[x, y-1] == :point &&
        self[x, y+1] == :point &&
        self[x-1, y] == :point &&
        self[x+1, y] == :point
  end

  def format
    puts "#{@n} #{@m} #{@k}"
    @n.times do |y|
      str = ""
      @m.times do |x|
        str << (self[x, y] == :empty ? '-' : '+')
      end
      puts "#{str}\n"
    end
    puts "\n"
  end

  def [](x, y)
    point = y * @m + x
    if x < 0 || y < 0 || x >= @m || y >= @n
      :out_of_grid
    else
      @grid[y * @m + x]
    end
  end

  def []=(x, y, value)
    point = y * @m + x
    if x < 0 || y < 0 || x >= @m || y >= @n
      :out_of_grid
    else
      @grid[y * @m + x] = value
    end
  end
end

filename = ARGV[0]

File::open(filename) { |file|
  status = :count
  count = 0
  case_number = 1
  file.each { |line|
    case status
      when :count
        count = line.to_i
        status = :case
      when :case
        enclosure = Enclosure.new(line, case_number)
        enclosure.solve
        case_number += 1
        if case_number > count then
          break
        end
    end
  }
}
