class Tribal
  def self.init_by_line(line)
    di, ni, wi, ei, si, delta_di, delta_pi, delta_si = line.split(/\s+/).map { |str| str.to_i }
    self.new di: di, ni: ni, wi: wi, ei: ei, si: si, delta_di: delta_di, delta_pi: delta_pi, delta_si: delta_si
  end

  def initialize(options)
    @prop = {}
    [:di, :ni, :wi, :ei, :si, :delta_di, :delta_pi, :delta_si ].each do |key|
      @prop[key] = options[key]
    end
    @turn = 0
  end

  def attack?
    return false if attack_finished?
    (@turn - di) % delta_di == 0
  end

  def attack_finished?
    di + delta_di * ni < @turn
  end

  def get_action

  end

  def next_turn
    @turn += 1
  end

  def method_missing(method_name, *args)
    if method_name =~ /\A([^=]+)=\Z/
      obj = class << self; self end
      obj.class_eval do
        define_method(method_name) do |value|
          @prop[$1.to_sym] = value
        end
      end
      __send__ "#{method_name}", args[0]
    else
      obj = class << self; self end
      obj.class_eval do
        define_method(method_name) do
          @prop[method_name.to_sym]
        end
      end
      __send__ "#{method_name}"
    end
  end
end

class Action
  attr :west, :east, :strength
end

class GreatWall

  def solve
    # 部族の初期化

    # ターン処理
    loop do
      turn
      break if attack_finished?
    end

    # 結果出力
    puts "Case #{@number} @attacked_count"
  end

  def turn
    damages = []
    @tribals.each do |tribal|
      # 部族ごとに攻撃
      action = tribal.get_action
      unless action.nil?
        # 部族の攻撃
        damage = attacked action
        unless damage.nil?
          # 襲撃成功
          damages << damage
          @attacked_count += 1
        end
      end
      tribal.next_turn
    end
    # 壁の建設

    # ターン終了して次の日へ
    @turn += 1
  end

  def attacked(action)

  end

  def attack_finished?

  end
end