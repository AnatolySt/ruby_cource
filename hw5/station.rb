class Station
  attr_accessor :name
  @@instances = []

  def initialize(name)
    @name = name    
    @on_station = []
    @@instances << self
  end

  def self.all
    @@instances.inspect
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