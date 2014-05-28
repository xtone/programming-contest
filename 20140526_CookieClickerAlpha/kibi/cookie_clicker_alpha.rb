class CookieClickerAlpha
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      io.gets.to_i.times do |i|
        goal_time = solve *io.gets.split(' ').map{ |item| item.to_f }
        output i+1, goal_time
      end
    end
  end

  private

  # 問題を解く
  # @param [Float] c クッキーファームを購入するのに必要なクッキー枚数
  # @param [Float] f クッキーファームにより加算される毎秒加算クッキー枚数
  # @param [Float] x 勝利条件のクッキー枚数
  # @return [Float] クリアまでにかかる時間(s)
  def solve(c, f, x)
    goal_time = 0.0
    gain = 2.0
    while cookie_farm_beneficial?(c, f, x, gain)
      goal_time += c / gain
      gain += f
    end
    goal_time += x / gain
  end

  # クッキーファームを追加する場合としない場合で、クッキー所持数0枚の状態からクリアまでの時間を比較する
  # @param [Float] c クッキーファームを購入するのに必要なクッキー枚数
  # @param [Float] f クッキーファームにより加算される毎秒加算クッキー枚数
  # @param [Float] x 勝利条件のクッキー枚数
  # @param [Float] gain 1秒あたりに得られるクッキー枚数
  # @return [Boolean] クッキーファームを追加した方がクリア時間が短くなるならtrue
  def cookie_farm_beneficial?(c, f, x, gain)
    c / gain + x / (gain + f) < x / gain
  end

  def output(case_id, goal_time)
    print "Case ##{case_id}: #{sprintf "%.7f", goal_time}\n"
  end
end



cca = CookieClickerAlpha.new ARGV[0]
cca.execute