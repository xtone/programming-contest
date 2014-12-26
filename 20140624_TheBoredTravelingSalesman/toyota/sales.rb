filename = ARGV[0]

class TravelingSalesman
  def initialize(attr)
    @city_count = attr[:city]
    @flight_count = attr[:flight]

    @cities = Array.new
  end
  
  def add_city(attr)
    @cities.push City.new(attr)
  end

  def add_flight(attr)
    @from_city = @cities[attr[:from]-1]
    @to_city = @cities[attr[:to]-1]

    @from_city.add_flight(@to_city)
  end

  def solve
    # スタート地点を選択
    first = start_city

    current = first
    current.connected_cities.each { |next_city|

    }

  end

  def retrieve(city, path, ticket)

  end

  private
  def start_city
    small = nil
    @cities.each { |city|
      small = city if small.nil?
      if small.postal_code > city.postal_code then
        small = city
      end
    }
    small
  end
end

class City
  attr_accessor :city_number, :postal_code, :connected_cities

  def initialize(attr)
    @city_number = attr[:city_number]
    @postal_code = attr[:postal_code]

    @connected_cities = Array.new
  end

  def add_flight(city)
    unless @connected_cities.include?(city) then
      @connected_cities.push(city)
      city.add_flight(self)
    end
  end
end

filename = ARGV[0]

File::open(filename) { |file|
  status = :count
  count = 0
  city_count = 0
  current_city_count = 1
  flight_count = 0
  current_flight_count = 1
  case_number = 1

  traveling_salesman = nil
  status = :count

  file.each { |line|
    line = line.chomp
    case status
      when :count
        count = line.to_i
        status = :city_flight
      when :city_flight
        city_count, flight_count = line.split(" ").map { |str| str.to_i }
        traveling_salesman = TravelingSalesman.new city: city_count, flight: flight_count
        status = :city
      when :city
        traveling_salesman.add_city city_number: current_city_count, postal_code: line
        unless city_count == current_city_count then
          current_city_count += 1
          next
        end
        current_city_count = 1
        if flight_count > 0 then
          status = :flight
        else
          status = :solve
        end
      when :flight
        from, to = line.split(" ").map { |str| str.to_i }
        traveling_salesman.add_flight from: from, to: to

        unless flight_count == current_flight_count then
          current_flight_count += 1
          next
        end

        status = :solve
    end

    if status == :solve then
      puts "Case #{case_number}: #{traveling_salesman.solve}"

      if case_number == count then
        break
      else
        case_number += 1
        current_flight_count = 1
        status = :city_flight
      end
    end
  }
}
