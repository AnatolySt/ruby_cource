require_relative 'validation.rb'

class Station
  include Validation
  attr_accessor :name
  @@instances = []

  def initialize(name)
    @name = name.to_s
    validate!
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

  protected

  def validate!
    raise "Название станции не может быть пустым" if name.nil?
    raise "Название станции должно содержать от 3 до 12 символов" if (name.length < 3) || (name.length > 12)
    true
  end

end