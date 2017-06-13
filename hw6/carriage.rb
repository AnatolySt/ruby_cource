require_relative 'validation.rb'

class Carriage
  include Validation
  include Manufacturer
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  protected

  def validate!
    raise "Тип поезда должен быть 'Passenger' или 'Cargo'" if (type != 'Passenger') && (type != 'Cargo')
    true
  end
end