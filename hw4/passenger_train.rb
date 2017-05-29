require_relative 'train.rb'

class PassengerTrain < Train
  
  def initialize(name)
    @name = name
    @type = 'Passenger'
    @vagons = []
    @speed = 0
    @num = 0
  end

end