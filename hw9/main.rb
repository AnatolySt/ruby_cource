require_relative 'classes/station.rb'
require_relative 'classes/route.rb'
require_relative 'classes/train.rb'
require_relative 'classes/passenger_train.rb'
require_relative 'classes/cargo_train.rb'
require_relative 'classes/carriage.rb'
require_relative 'classes/passenger_carriage.rb'
require_relative 'classes/cargo_carriage.rb'
require_relative 'module/manufacturer.rb'
require_relative 'module/validation.rb'
require_relative 'module/accessor.rb'
require_relative 'controller.rb'

Terminal = Controller.new

Terminal.show_menu

loop do
  Terminal.select_menu
  case Terminal.item

  when 1
    Terminal.create_station
  when 2
    Terminal.create_train
  when 3
    Terminal.create_route
  when 4
    Terminal.route_station_change
  when 5
    Terminal.route_to_train
  when 6
    Terminal.add_carriage
  when 7
    Terminal.delete_carriage
  when 8
    Terminal.change_station
  when 9
    Terminal.show_stations
  when 10
    Terminal.show_station_trains
  when 11
    Terminal.show_train_carriages
  when 12
    Terminal.take_carriage_space
  end
end
