class Enclosure
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      io.gets.to_i.times do |i|
        stones = solve *io.gets.split(' ').map{ |item| item.to_i }
        output i+1, stones
      end
    end
  rescue => e
    raise e, "Can't open input file."
  end

  private

  # 与えられた条件から、問題を解く
  # @param [Integer] n グリッドの横方向の点の数
  # @param [Integer] m グリッドの縦方向の点の数
  # @param [Integer] k 囲う交点の数
  # @return [Integer] 点を囲うのに必要最小限の石の個数
  def solve(n, m, k)
    # 縦または横の長さが3未満では、長方形を形成しても必要な石の個数が減らない
    short_grid = [n, m].min
    return k if short_grid < 3
    # 与えられた点の数に四隅の4点を加え、長方形に並べられるか判断する
    rectangle = k + 4
    short_side = factorize rectangle, short_grid
    if short_side == 0
      # 長方形は形成できないので、石の最小数＝交点の数
      return k
    else
      long_side = rectangle / short_side
      # 長方形の辺上に石を並べた後、最初に加えた四隅の点を除いた数が求める石の個数である
      return (long_side + short_side - 2) * 2 - 4
    end
  end

  # 長方形の面積の因数分解を行い、最も差の小さくなる場合の短辺の長さを返却する
  # @param [Integer] area 面積
  # @param [Integer] max グリッドの辺の短い方
  # @return [Integer] 割り切れない場合は0を返す
  def factorize(area, max)
    answer = 0
    [Math.sqrt(area).to_i, max].min.downto(2) do |i|
      next unless area % i == 0
      answer = i
      break
    end
    answer
  end

  # 答えを標準出力に出力する
  # @param [Integer] case_id
  # @param [Integer] stones
  def output(case_id, stones)
    print "Case ##{case_id}: #{stones}\n"
  end
end



begin
  enc = Enclosure.new ARGV[0]
  enc.execute
rescue => e
  print "#{e}\n"
end