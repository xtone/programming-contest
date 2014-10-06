# -*- coding: utf-8 -*-
class Matrix
  attr_accessor :matrix

  def initialize(n)
    @n = n
    @matrix = ''
    @initial_matrix = ''
    @cursor = 0
  end

  def update(str)
    if @cursor >= @n * 2 || str.length != @n * 2 then
      raise 'cannot update matrix.'
    end

    @matrix << str
    @initial_matrix << str
    @cursor += 1
  end

  def reset
    @matrix = @initial_matrix
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

  def can_solve?
    row = Array.new @n * 2, ''
    column = Array.new @n * 2, ''
    (@n * 2).times do |i|
      (@n * 2).times do |j|
        row[i] += self[i, j]
        column[j] += self[i, j]
      end
    end
    if row.uniq.length != 2 then
      return false
    elsif column.uniq.length != 2 then
      return false
    end
    true
  end

  def solve(case_number)
    unless can_solve? then
      puts "Case ##{case_number}: IMPOSSIBLE"
      return false
    end

    # 左上0の場合
    count = self.solve_count(0)
    self.reset
    # 左上1の場合
    count_2 = self.solve_count(1)

    puts "Case ##{case_number}: #{[count, count_2].min}"
    return true
  end

  def solve_count(left)
    # 行の入れ替え
    count = 0
    (@n * 2).times do |i|
      if self[i, 0].to_i != i % 2 then
        # puts "row #{i}: #{self[i, 0]}"
        (i+1..@n*2-1).select { |x| x % 2 == (i+1) % 2 }.each { |j|
          if self[j, 0].to_i == i % 2 then
            # puts "exchange_row #{j} #{self[j, 0]}"
            self.exchange_row(i, j)
            count += 1
            break
          end
        }
      end
    end
    # 列の入れ替え
    (@n * 2).times do |i|
      if self[0, i].to_i != i % 2 then
        # puts "column #{i}: #{self[0, i]}"
        (i+1..@n*2-1).select { |x| x % 2 == (i+1) % 2 }.each { |j|
          if self[0, j].to_i == i % 2 then
            # puts "exchange_column #{j} #{self[0, j]}"
            self.exchange_column(i, j)
            count += 1
            break
          end
        }
      end
    end
    count
  end

  def self.goal_matrix(n, start=0)
    m = Matrix.new(n)
    matrix = ''
    current = start
    (n*2).times do |i|
      (n*2).times do |j|
        matrix << current.to_s
        current = current == 0 ? 1 : 0
      end
      m.update(matrix)
      matrix = ''
      current = current == 0 ? 1 : 0
    end
    m
  end
end

require 'pp'

class SampleReader
  attr_accessor :case_complete, :matrix, :case

  def initialize
    @status = :q_count
  end

  def add_line(line)
    case @status
    when :q_count
      @question_count = line.to_i
      @case = 0
      @all_complete = false
      @case_complete = false
      @status = :line_count
    when :line_count
      @matrix = Matrix.new(line.to_i)
      @case += 1
      @status = :line
      @case_complete = false
      @rest_line = line.to_i * 2
    when :line
      @matrix.update(line.strip)
      @rest_line -= 1
      if @rest_line <= 0 then
        @case_complete = true
        if @question_count == @case
          @status = :finished
          @all_complete = true
        else
          @status = :line_count
        end
      end
    end
  end
end

filename = ARGV[0]
reader = SampleReader.new
File::open(filename) { |file|
  impossible_count = 0
  file.each { |line|
    reader.add_line(line)
    if reader.case_complete then
      unless reader.matrix.solve(reader.case) then
        impossible_count += 1
      end
    end
  }
  # puts "impossible_count: #{impossible_count}"
}
