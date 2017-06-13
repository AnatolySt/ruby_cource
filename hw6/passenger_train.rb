require_relative 'train.rb'

class PassengerTrain < Train
  
  def initialize(name, number)
    super(name, speed, number)
    validate!
    @type = 'Passenger'
  end

end