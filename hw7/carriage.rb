require_relative 'validation.rb'

class Carriage
  include Validation
  include Manufacturer
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Тип вагона должен быть 'Passenger' или 'Cargo'" if (type != 'Passenger') && (type != 'Cargo')
    true
  end
end