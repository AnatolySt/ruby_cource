class CargoCarriage < Carriage
  attr_reader :amount_taken, :amount_free

  def initialize(amount)
    @type = "Cargo"
    @amount = amount
    @amount_taken = 0
  end

  def take_amount(quantity)
    self.amount_free
    if @amount_free > quantity
      @amount_taken += quantity
    else
      puts "Недостаточно свободного места в вагоне"
    end
  end

  def amount_free
    @amount_free = @amount - @amount_taken
  end
end