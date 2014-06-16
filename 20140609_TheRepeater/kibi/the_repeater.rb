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
  # @return [Integer | nil] 勝利するために必要な手数
  def solve(strings, n)
    shortest_string = strings[0].squeeze
    counts = Array.new
    number_of_moves = 0
    strings.each do |string|
      return nil unless shortest_string == string.squeeze
      counts << count_continuing_chars_length(string)
    end
    shortest_string.length.times do |i|
      tmp_array = []
      n.times do |j|
        tmp_array << counts[j][i]
      end
      average = tmp_array.average.ceil
      n.times do |j|
        number_of_moves += (counts[j][i] - average).abs
      end
    end
    number_of_moves
  end

  # 文字列中に連続する同じ文字の数を数える
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

  def output(case_id, number_of_moves)
    number_of_moves ||= 'Fegla Won'
    print "Case ##{case_id}: #{number_of_moves}\n"
  end
end


class Array
  # 配列の全要素の平均値を求める
  # @return [Float]
  def average
    inject(0.0){ |sum, i| sum += i } / size
  end
end



tr = TheRepeater.new ARGV[0]
tr.execute