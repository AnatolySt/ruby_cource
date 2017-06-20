class PassengerCarriage < Carriage
  attr_reader :seats_taken, :seats_free

  def initialize(seats)
    @type = "Passenger"
    @seats = seats
    @seats_taken = 0
  end

  def take_seat
    @seats_taken += 1
  end

  def seats_free
    @seats_free = @seats - @seats_taken
  end
end