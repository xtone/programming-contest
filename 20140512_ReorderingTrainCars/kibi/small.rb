rtc = new ReorderTrainCar '../input/B-small-practice.in'
rtc.execute



class ReorderTrainCar
  def initialize(input_file_path)
    @input_file_path = input_file_path
  end

  def execute
    File.open @input_file_path, 'r' do |io|
      io.gets.to_i.times do |i|
        train_count = io.gets.to_i
        trains = generate_train io.gets, train_count
        trains.each do |train|
          # 枝切り

        end
      end
    end
  end

  def generate_train(source, count)
    source.squeeze.split(' ')[0...count]
  end
end