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
    print "11. Просмотреть список вагонов у поезда \n"
    print "12. Занять место/объем в вагоне \n"
  end

  def select_menu
    puts 'Выберите пункт меню (номер)'
    @item = gets.chomp.to_i
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def show_stations
    @stations.each_with_index do |station, id|
      print "#{id}. #{station.name} \n"
    end
  end

  def create_train
    puts 'Выберите тип поезда: (P - пассажирский, C - товарный)'
    train_type = gets.chomp.upcase
    puts 'Введите номер поезда'
    train_number = gets.chomp
    puts 'Введите название поезда'
    train_name = gets.chomp
    if train_type == 'P'
      @trains << PassengerTrain.new(train_name, train_number)
    elsif train_type == 'C'
      @trains << CargoTrain.new(train_name, train_number)
    else
      print 'Ошибка!'
    end
  rescue Exception => e
    puts e.message
  end

  def show_trains
    @trains.each_with_index do |train, id|
      print "#{id}. #{train.name} - #{train.type} \n"
    end
  end

  def create_route
    show_stations
    puts 'Введите номер станции отправления'
    start_id = gets.chomp.to_i
    puts 'Введите номер конечной станции'
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
    show_routes
    puts 'Выберите маршрут (номер)'
    route_id = gets.chomp.to_i

    puts 'Станции маршрута:'
    @routes[route_id].show_stations

    puts '1 - Добавить станцию | 2 - Удалить станцию | 3 - Выход'
    action_select = gets.chomp.to_i
    puts 'Все станции:'
    show_stations
    puts 'Введите номер станции'
    station_id = gets.chomp.to_i

    case action_select
    when 1
      @routes[route_id].add_station(@stations[station_id])
    when 2
      @routes[route_id].delete_station(@stations[station_id])
    else
      print 'Выход в основное меню..'
    end

    puts @routes[route_id].show_stations
  end

  def route_to_train
    if @routes == [] || @trains == []
      puts 'Не создано поездов или маршрутов'
    else
      puts 'Все поезда:'
      show_trains
      puts 'Все маршруты:'
      show_routes

      puts 'Номер поезда:'
      @train_id = gets.chomp.to_i
      puts 'Номер маршрута:'
      route_id = gets.chomp.to_i

      @trains[@train_id].get_route(@routes[route_id])
      puts @trains[@train_id].current_station.name
    end
  end

  def select_train
    show_trains
    puts 'Выберите поезд (номер)'
    @train_id = gets.chomp.to_i
  end

  def add_carriage
    select_train
    puts 'Выберите тип вагона: P - пассажирский, C - грузовой'
    type = gets.chomp.upcase

    if type == 'P'
      puts 'Введите количество мест'
      seats = gets.chomp.to_i
      @trains[@train_id].add_vagon(PassengerCarriage.new(seats))
      puts @trains[@train_id].vagons[0]
    elsif type == 'C'
      puts 'Введите общий объем'
      amount = gets.chomp.to_i
      @trains[@train_id].add_vagon(CargoCarriage.new(amount))
      puts @trains[@train_id].vagons[0]
    else
      print 'Ошибка!'
    end
  end

  def delete_carriage
    select_train
    @trains[@train_id].delete_vagon
  end

  def train_change_station
    select_train
    puts '1 - Вперед по маршруту, 2 - Назад по маршруту'
    action_select = gets.chomp.to_i
    if action_select == 1
      @trains[@train_id].next_station
    elsif action_select == 2
      @trains[@train_id].previous_station
    end
  end

  def show_station_trains
    show_stations
    puts 'Выберите станцию (номер)'
    station_id = gets.chomp.to_i

    @stations[station_id].each_train { |train| print "#{train.name}, #{train.type}, #{train.vagons.length} \n" }
  end

  def show_train_carriages
    select_train

    @trains[@train_id].each_carriage do |index, vagon|
      if @trains[@train_id].type == 'Passenger'
        print "Вагон №#{index + 1}: количество занятых мест - #{vagon.seats_taken}, свободных мест - #{vagon.seats_free} \n"
      elsif @trains[@train_id].type == 'Cargo'
        print "Вагон №#{index + 1}: занятый объем - #{vagon.amount_taken}, доступный объем - #{vagon.amount_free} \n"
      end
    end
  end

  def take_carriage_space
    select_train

    @trains[@train_id].each_carriage do |index, vagon|
      if @trains[@train_id].type == 'Passenger'
        print "Вагон №#{index + 1}: количество занятых мест - #{vagon.seats_taken}, свободных мест - #{vagon.seats_free} \n"
      elsif @trains[@train_id].type == 'Cargo'
        print "Вагон №#{index + 1}: занятый объем - #{vagon.amount_taken}, доступный объем - #{vagon.amount_free} \n"
      end
    end

    puts 'Выберите вагон (номер)'
    vagon_id = gets.chomp.to_i
    if @trains[@train_id].type == 'Passenger'
      puts 'Введите количество занимаемых мест'
      num_taken_seats = gets.chomp.to_i
      1.upto(num_taken_seats) { @trains[@train_id].vagons[vagon_id].take_seat }
    elsif @trains[@train_id].type == 'Cargo'
      puts 'Введите количество занимаемого объема'
      taken_amount = gets.chomp.to_i
      @trains[@train_id].vagons[vagon_id].take_amount(taken_amount)
    end
  end
end
