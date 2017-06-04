class Station
  attr_accessor :name

  def initialize(name)
    @name = name    
    @on_station = []
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end


  def arrive(train_obj)
    @on_station << train_obj
  end

  def on_station(type = "all")
    if type != "all"
      @on_station.select {|train_obj| train_obj.type == type}
    elsif type == "all"
      @on_station
    end
  end

  def depart(train)
    @on_station.delete(train)
  end

end