class Train
  attr_accessor :speed, :route, :current_station, :name, :type, :vagons

  def initialize(name, type)
    @name = name
    @type = type
    @vagons = []
    @speed = 0
    @num = 0
  end

  def speed_up
    @speed += 20
  end

  def stop
    @speed = 0
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

end