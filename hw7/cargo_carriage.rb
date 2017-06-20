class CargoCarriage < Carriage
  attr_reader :amount_taken, :amount_free

  def initialize(amount)
    @type = "Cargo"
    @amount = amount
    @amount_taken = 0
  end

  def take_amount(quantity)
    @amount_taken += quantity
  end

  def amount_free
    @amount_free = @amount - @amount_taken
  end
end