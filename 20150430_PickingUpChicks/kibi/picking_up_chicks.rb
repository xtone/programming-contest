class Chick
  attr_accessor :x

  def initialize(x, v)
    @x = x
    @v = v
  end

  def arrived?(b)
    b <= @x
  end

  def run
    @x += @v
  end
end

class PickingUpChicks
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      (io.gets.to_i).times do |i|
        # N, K, B, Tが書いてある行
        n, k, b, t = *io.gets.split(' ').map{ |item| item.to_i }
        # N個の異なる整数Xiが書いてある行
        x = io.gets.split(' ').map{ |item| item.to_i }
        # N個のViが書いてある行
        v = io.gets.split(' ').map{ |item| item.to_i }

        solved = false
        chicks = []
        n.times do |nn|
          chicks << Chick.new(x[nn], v[nn])
        end
        # クレーン使用回数の最大は、N羽の鶏のうちの2羽の組み合わせの総数
        # 0回の場合を含めるので、+1する
        (n*(n-1)/2 + 1).times do |s|
          if solved = solve(n, k, b, t, deep_copy(chicks), s)
            output i+1, s
            break
          end
        end
        unless solved
          output i+1, 'IMPOSSIBLE'
        end
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
  # @param [Integer] s クレーンを使っていい回数
  # @return [TrueClass | FalseClass] クリアできたらtrue
  def solve(n, k, b, t, chicks, s)
    # 1秒ごとの処理
    t.times do |tt|
      # 鶏ごとの移動処理
      chicks.each do |chick|
        chick.run
      end
      # 1つ前を行く鶏を追い越していたら、その位置まで戻す。
      # クレーン使用回数が残っていれば、それを消費して鶏の順序を入れ替え、上記の処理をスキップする。
      if 1 < n
        (n-2).downto(0) do |nn|
          nn.upto(n-1) do |mm|
            next if chicks[nn].x <= chicks[mm].x
            if 0 < s
              s -= 1
              chicks[nn], chicks[mm] = chicks[mm], chicks[nn]
            else
              chicks[nn].x = chicks[mm].x
            end
          end
        end
      end
      # 現在位置チェック(debug)
      #p chicks_position(chicks)
      # 鶏小屋に入った鶏のチェック
      arrived_count = 0
      chicks.each do |chick|
        arrived_count += 1 if chick.arrived?(b)
      end
      # 鶏小屋に入った鶏の数が規定値を超えたら終了
      return true if k <= arrived_count
    end
    false
  end

  def deep_copy(a)
    Marshal.load(Marshal.dump(a))
  end

  def output(case_id, result)
    print "Case ##{case_id}: #{result}\n"
  end

  def chicks_position(chicks)
    pos = []
    chicks.each do |chick|
      pos << chick.x
    end
    pos
  end
end



cca = PickingUpChicks.new ARGV[0]
cca.execute
