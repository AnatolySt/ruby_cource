require_relative 'validation.rb'
require_relative 'manufacturer.rb'

class Train
  include Manufacturer
  include Validation
  attr_accessor :speed, :route, :current_station, :name, :type, :vagons, :number
  @@instances = {}
  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(name, number, type)
    @name = name
    @type = type
    @number = number # номер поезда
    validate!
    @vagons = []
    @speed = 0
    @num = 0
    @@instances[number] = self
  end

  def self.find(number)
    @@instances[number]
  end

  def add_vagon(vagon)
    if @speed == 0 && vagon.type == @type
      @vagons << vagon
    else
      puts "Остановите поезд или выберите подходящий вагон!"
    end
  end

  def delete_vagon
    if @speed == 0 && @vagons > 0
      @vagons.delete_at(-1)
    else
      puts "Ошибка"
    end
  end

  def get_route(route)
    @route = route
    @current_station = @route.route_arr[@num]
    @current_station.arrive(self)    
  end

  def next_station
    @current_station.depart(self)
    @num += 1
    @current_station = @route.route_arr[@num]
    @current_station.arrive(self)
  end

  def previous_station
    @current_station.depart(self)
    @num -= 1
    @current_station = @route.route_arr[@num]    
    @current_station.arrive(self)
  end

  def return_previous
    @previous_station = @route.route_arr[@num - 1]
  end

  def return_next
    @next_station = @route.route_arr[@num + 1]
  end

  protected

  def speed_up
    @speed += 20
  end

  def stop
    @speed = 0
  end

  def validate!
    raise "Название поезда не может быть пустым" if name.nil?
    raise "Название поезда должно содержать от 3 до 12 символов" if (name.length < 3) || (name.length > 12)
    raise "Номер поезда не соответствует шаблону. Попробуйте еще раз." if number !~ NUMBER_FORMAT
    true
  end

end