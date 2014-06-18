class TheRepeater
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 最初の行にtest caseの数が記載。
      (1..io.gets.to_i).each do |case_id|
        strings = []
        n = io.gets.to_i
        n.times do |i|
          strings << io.gets.chomp
        end
        number_of_moves = solve strings, n
        output case_id, number_of_moves
      end
    end
  end

  private

  # 問題を解く
  # @param [Array] strings 課題となる文字列群
  # @param [Integer] n 課題となる文字列の数
  # @return [Integer | nil] 勝利するために必要な手数, 勝利できない場合はnil
  def solve(strings, n)
    shortest_string = strings[0].squeeze
    m = shortest_string.length
    chars_length = []
    number_of_moves = 0
    strings.each do |string|
      # squeeze が一致しないものは解決不可
      return nil unless shortest_string == string.squeeze
      chars_length << count_continuing_chars_length(string)
    end
    medians = median_row chars_length, m, n
    # 文字列を構成する文字種ごとに、手数を計算する。
    # 文字数を一致させるための最少手数は、
    # 「現在の文字列内の文字数」と「全文字列内の文字数の中央値」の差の絶対値を取ることで求められる。
    m.times do |i|
      n.times do |j|
        number_of_moves += (chars_length[j][i] - medians[i].round).abs
      end
    end
    number_of_moves
  end

  # 文字列中に連続する同じ文字の数を数える
  # @example
  #   "abbcddd" #=> [1,2,1,3]
  # @param [String] string 文字列
  # @return [Array] 連続する数
  def count_continuing_chars_length(string)
    counts = Array[0]
    index = 0
    current = string[0]
    string.chars do |char|
      if current == char
        counts[index] += 1
      else
        current = char
        counts << 1
        index += 1
      end
    end
    counts
  end

  # col行row列の数値要素をもつ2次元配列の、列ごとの中央値を求める
  # @example
  #   [[2,4,3], [3,7,1], [4,2,9]] #=> [3,4,3]
  # @param [Array] array
  # @param [Integer] col
  # @param [Integer] row
  # @return [Array] 列ごとの中央値
  def median_row(array, col, row)
    median = []
    col.times do |i|
      tmp_array = []
      row.times do |j|
        tmp_array << array[j][i]
      end
      median << tmp_array.median
    end
    median
  end

  def output(case_id, number_of_moves)
    number_of_moves ||= 'Fegla Won'
    print "Case ##{case_id}: #{number_of_moves}\n"
  end
end


class Array
  # 数列の中央値を求める
  # @return [Float] 中央値
  def median
    array = self.sort
    quotient, remainder = size.divmod 2
    if remainder == 0
      (array[quotient-1] + array[quotient]) / 2.0
    else
      array[quotient]
    end
  end
end



tr = TheRepeater.new ARGV[0]
tr.execute