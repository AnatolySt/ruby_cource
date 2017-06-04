require_relative 'train.rb'

class PassengerTrain < Train
  
  def initialize(name)
    super(name, speed, num, number)
    @vagons = []
    @type = 'Passenger'
  end

end