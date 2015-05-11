class MinesweeperMaster
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      (1..io.gets.to_i).each do |case_id|
        answer = solve *io.gets.split(' ').map{ |item| item.to_i }
        output case_id, answer
      end
    end
  end

  private

  # 問題を解く
  # @param [Integer] r 盤面の縦幅
  # @param [Integer] c 盤面の横幅
  # @param [Integer] m 隠された地雷の数
  # @return [String] 1回の選択で勝てる場合の盤面
  def solve(r, c, m)

  end
end


mm = MinesweeperMaster.new ARGV[0]
mm.execute