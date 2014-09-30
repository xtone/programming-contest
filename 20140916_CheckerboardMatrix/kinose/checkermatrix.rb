require 'matrix'

class Matrix
  attr_accessor :scale
  @scale = 0
  @cursor = 0

  def clone
    ret = super
    ret.scale = self.scale
    ret
  end

  def swap_row!(a, b)
    self.row_size.times do |i|
      self[a, i], self[b, i] = self[b, i], self[a, i]
    end
  end

  def swap_column!(a, b)
    self.column_size.times do |i|
      self[i, a], self[i, b] = self[i, b], self[i, a]
    end
  end

  def show
    self.rows.each do |row|
      p row.to_a
    end
  end

  def verify?
    self.eql?(Matrix.goal(self.scale, self[0, 0] == 0))
    # p "compare"
    # (Matrix.goal(self.scale, self[0, 0] == 0) - self).show
  end

  # n: inputから取得した数値
  def self.goal(n, zero_origin)
    goal_rows = []
    current = zero_origin
    (n * 2).times do
      goal_rows << (current ? [0, 1] : [1, 0]) * n
      current = ! current
    end
    Matrix.rows goal_rows
  end

end

