class Matrix
  def initialize(n)
    @n = n
    @matrix = ''
    @cursor = 0
  end

  def update(str)
    if @cursor >= @n * 2 || str.length != @n * 2 then
      raise 'cannot update matrix.'
    end

    @matrix << str
    @cursor += 1
  end

  def exchange_row(a, b)
    (@n * 2).times do |i|
      tmp = self[a, i]
      self[a, i] = self[b, i]
      self[b, i] = tmp
    end
  end

  def exchange_column(a, b)
    (@n * 2).times do |i|
      tmp = self[i, a]
      self[i, a] = self[i, b]
      self[i, b] = tmp
    end
  end

  def [](row, col)
    @matrix[row * @n * 2 + col]
  end

  def []=(row, col, value)
    @matrix[row * @n * 2 + col] = value
  end

  def print
    (@n * 2).times do |i|
      line = ''
      (@n * 2).times do |j|
        line << "#{self[i, j]} "
      end
      puts line
    end
  end

  def self.goal_matrix(n, start=0)
    matrix = ''
    current = start
    (n*2).times do |i|
      (n*2).times do |j|
        matrix << current.to_s
        current = current == 0 ? 1 : 0
      end
    end
    matrix
  end
end