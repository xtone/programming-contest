class MagicTrick
  def initialize(filepath)
    @input_file_path = filepath
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      # 最初の行にtest caseの数が記載。
      io.gets.to_i.times do |i|
        first_cards = select_cards io
        second_cards = select_cards io
        output i+1, first_cards, second_cards
      end
    end
  rescue => e
    raise e, "Can't open input file."
  end

  private

  # 与えられた条件から、客の指定したカードの列を返す
  # @param [IO] io
  # @return [Array]
  def select_cards(io)
    # test caseの1行目に、1回目の客の言った答えが記載。
    answer = io.gets.to_i - 1
    # 2行目〜5行目に、カードの配置が記載。
    cards = []
    4.times do |i|
      str = io.gets
      next unless i == answer
      cards = str.split(' ').map{ |item| item.to_i }
    end
    cards
  end

  # 2回分のカードの配列の積集合を取り、答えを標準出力に出力する
  # @param [Integer] case_id
  # @param [Array] first_cards
  # @param [Array] second_cards
  def output(case_id, first_cards, second_cards)
    answer = first_cards & second_cards
    case answer.size
      when 0
        print "Case ##{case_id}: Volunteer cheated!\n"
      when 1
        print "Case ##{case_id}: #{answer[0]}\n"
      else
        print "Case ##{case_id}: Bad magician!\n"
    end
  end
end



begin
  mt = MagicTrick.new ARGV[0]
  mt.execute
rescue => e
  print e
end