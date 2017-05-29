require_relative 'train.rb'

class CargoTrain < Train
  
  def initialize(name)
    @name = name
    @type = 'Cargo'
    @vagons = []
    @speed = 0
    @num = 0
  end

end
