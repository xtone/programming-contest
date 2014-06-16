class PartElf
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 1行目にテストケースの数が書いてある
      (1..io.gets.to_i).each do |i|
        generation = solve *io.gets.split('/').map{ |item| item.to_i }
        output i, generation
      end
    end
  end

  private

  # 問題を解く
  # @param [Integer] p エルフの血の割合(分子)
  # @param [Integer] q エルフの血の割合(分母)
  # @return [Integer | nil] 純血のエルフであった最近の世代
  def solve(p, q)
    p, q = lowest_terms p, q
    # 分母が2の乗数じゃないのはおかしい
    return nil unless multiplier_of_two? q
    generation = 1
    while generation <= 40
      p, q = darker_parent p, q
      return generation if p == q
      generation += 1
    end
    nil
  end

  # numが2の乗数であるかを調べる
  # @param [Integer] num
  # @return [Boolean]
  def multiplier_of_two?(num)
    root = 1
    while root <= num
      return true if num == root
      root *= 2
    end
    false
  end

  # 約分する
  # @param [Integer] p 分子
  # @param [Integer] q 分母
  # @return [Array] 約分された分子、分母
  def lowest_terms(p, q)
    r = euclidean_algorithm p, q
    return p / r, q / r
  end

  # ユークリッドの互除法
  # @param [Integer] m
  # @param [Integer] n
  # @return [Integer] mとnの最大公約数
  def euclidean_algorithm(m, n)
    m, n = n, m if m < n
    loop do
      r = m % n
      return n if r == 0
      m, n = n, r
    end
  end

  # 両親のうち、エルフの血が濃い方の血の分数を返す
  # @param [Integer] p エルフの血の割合(分子)
  # @param [Integer] q エルフの血の割合(分母)
  # @return [Array]
  def darker_parent(p, q)
    parent = [p, q/2]
    parent[0] = parent[1] if parent[1] < parent[0]
    parent
  end

  def output(case_id, generation)
    generation ||= 'impossible'
    print "Case ##{case_id}: #{generation}\n"
  end
end



pe = PartElf.new ARGV[0]
pe.execute