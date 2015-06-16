# = 鶏オブジェクト
class Chick
  # コンストラクタ
  # @param [Integer] x 初期座標
  # @param [Integer] v 速度
  def initialize(x, v)
    @x = x
    @v = v
  end

  # 鶏小屋に入った？
  # @param [Integer] b 鶏小屋の座標
  # @return [TrueClass | FalseClass]
  def arrived?(b)
    b <= @x
  end

  # 鶏を走らせる
  # @param [Integer] second 走らせる時間
  # @return [Integer] 走った後の座標
  def run(second)
    @x += @v * second
  end
end

class PickingUpChicks
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      for case_no in 1..(io.gets.to_i)
        # N, K, B, Tが書いてある行
        n, k, b, t = *io.gets.split(' ').map { |item| item.to_i }
        # N個の異なる整数Xiが書いてある行
        x = io.gets.split(' ').map { |item| item.to_i }
        # N個のViが書いてある行
        v = io.gets.split(' ').map { |item| item.to_i }

        chicks = []
        n.times do |i|
          chicks << Chick.new(x[i], v[i])
        end
        output case_no, solve(n, k, b, t, chicks)
      end
    end
  end

  private

  # 問題を解く
  # @param [Integer] n 鶏の総数
  # @param [Integer] k 鶏小屋に追い込まなければならない鶏の数
  # @param [Integer] b 鶏小屋の位置(m)
  # @param [Integer] t 制限時間(s)
  # @param [Array] chicks 鶏のインスタンス配列
  # @return [Integer | String] クリアできたらクレーンの使用回数、クリアできなければ'IMPOSSIBLE'
  def solve(n, k, b, t, chicks)
    s = 0
    arrival = 0
    non_arrival = 0
    # t秒後の鶏の位置を初期位置が鶏小屋に近いものからチェック
    chicks.reverse_each do |chick|
      chick.run t
      if chick.arrived? b
        arrival += 1
        s += non_arrival
      else
        non_arrival += 1
      end
      return s if k <= arrival
    end
    'IMPOSSIBLE'
  end

  def output(case_no, result)
    print "Case ##{case_no}: #{result}\n"
  end

  def chicks_position(chicks)
    chicks.map { |chick| chick.x }
  end
end



PickingUpChicks.new(ARGV[0]).execute
