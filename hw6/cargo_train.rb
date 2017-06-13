require_relative 'train.rb'

class CargoTrain < Train
  
  def initialize(name, number)
    super(name, speed, number)
    validate!
    @type = 'Cargo'
  end

end
