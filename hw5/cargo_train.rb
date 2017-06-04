require_relative 'train.rb'

class CargoTrain < Train
  
  def initialize(name)
    super(name, speed, num, number)
    @vagons = []
    @type = 'Cargo'
  end

end
