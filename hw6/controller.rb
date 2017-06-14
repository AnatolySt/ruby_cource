class Controller

  attr_reader :item

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_menu
    print "1. Создать станцию \n"
    print "2. Создать поезд \n"
    print "3. Создать маршрут \n"
    print "4. Добавить/Удалить станцию из машрута \n"
    print "5. Назначить маршрут поезду \n"
    print "6. Добавить вагон к поезду \n"
    print "7. Отцепить вагон от поезда \n"
    print "8. Переместить поезд \n"
    print "9. Просмотреть список станций \n"
    print "10. Просмотреть список поездов на станции \n"
  end

  def select_menu
    puts "Выберите пункт меню (номер)"
    @item = gets.chomp.to_i
  end

  def create_station
    puts "Введите название станции"
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def show_stations
    @stations.each_with_index do |station, id|
      print "#{id}. #{station.name} \n"
    end
  end

  def create_train
    puts "Выберите тип поезда: (P - пассажирский, C - товарный)"
    train_type = gets.chomp.upcase
    puts "Введите номер поезда"
    train_number = gets.chomp
    puts "Введите название поезда"
    train_name = gets.chomp
    if train_type == "P"
      @trains << PassengerTrain.new(train_name, train_number)
    elsif train_type == "C"
      @trains << CargoTrain.new(train_name, train_number)
    else
      print "Ошибка!"
  rescue Exception => e
    puts e.message
  end

  def show_trains
    @trains.each_with_index do |train, id|
      print "#{id}. #{train.name} - #{train.type} \n"
    end
  end

  def create_route
    self.show_stations
    puts "Введите номер станции отправления"
    start_id = gets.chomp.to_i
    puts "Введите номер конечной станции"
    last_id = gets.chomp.to_i
    @routes << Route.new(@stations[start_id], @stations[last_id])
    puts @routes[-1].show_stations
  end

  def show_routes
    @routes.each_with_index do |route, id|
      print "#{id}. #{route.route_arr[0].name} - #{route.route_arr[-1].name} \n"
    end
  end

  def route_station_change
    self.show_routes
    puts "Выберите маршрут (номер)"
    route_id = gets.chomp.to_i

    puts "Станции маршрута:"
    @routes[route_id].show_stations

    puts "1 - Добавить станцию | 2 - Удалить станцию | 3 - Выход"
    action_select = gets.chomp.to_i
    puts "Все станции:"
    self.show_stations
    puts "Введите номер станции"
    station_id = gets.chomp.to_i

    case action_select
    when 1
      @routes[route_id].add_station(@stations[station_id])
    when 2
      @routes[route_id].delete_station(@stations[station_id])
    else
      print "Выход в основное меню.."
    end

    puts @routes[route_id].show_stations
  end

  def route_to_train
    if @routes == [] || @trains == []
      puts "Не создано поездов или маршрутов"
    else
      puts "Все поезда:"
      self.show_trains
      puts "Все маршруты:"
      self.show_routes

      puts "Номер поезда:"
      train_id = gets.chomp.to_i
      puts "Номер маршрута:"
      route_id = gets.chomp.to_i

      @trains[train_id].get_route(@routes[route_id])
      puts @trains[train_id].current_station.name
    end
  end

  def add_carriage
    self.show_trains
    puts "Выберите поезд (номер)"
    train_id = gets.chomp.to_i
    puts "Выберите тип вагона: P - пассажирский, C - грузовой"
    type = gets.chomp.upcase

    if type == "P"
      @trains[train_id].add_vagon(PassengerCarriage.new)
      puts @trains[train_id].vagons[0]
    elsif type == "C"
      @trains[train_id].add_vagon(CargoCarriage.new)
      puts @trains[train_id].vagons[0]
    else
      print "Ошибка!"
    end
  end

  def delete_carriage
    self.show_trains
    puts "Выберите поезд (номер)"
    train_id = gets.chomp.to_i
    @trains[train_id].delete_vagon
  end

  def train_change_station
    self.show_trains
    puts "Выберите поезд (номер)"
    train_id = gets.chomp.to_i
    puts "1 - Вперед по маршруту, 2 - Назад по маршруту"
    action_select = gets.chomp.to_i
    if action_select == 1
      @trains[train_id].next_station
    elsif action_select == 2
      @trains[train_id].previous_station
    end
  end

  def show_station_trains
    self.show_stations
    puts "Выберите станцию (номер)"
    station_id = gets.chomp.to_i

    trains_on_station = @stations[station_id].on_station
    trains_on_station.each do |train|
      print "#{train.name} \n"
    end
  end

end

