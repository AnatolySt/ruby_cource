require_relative '../modules/validation.rb'

class Route
  include Validation
  attr_accessor :route_arr

  def initialize(first, last)
    @route_arr = [first, last]
    validate!
  end

  def add_station(station, num = -2)
    @route_arr.insert(num, station)
  end

  def delete_station(station)
    @route_arr.delete(station)
  end

  def show_stations
    @route_arr.each_with_index do |station, id|
      puts "#{id}. #{station.name} "
    end
  end
end
