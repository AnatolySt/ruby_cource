class PassengerCarriage < Carriage
  attr_reader :seats_taken, :seats_free

  def initialize(seats)
    @type = "Passenger"
    @seats = seats
    @seats_taken = 0
  end

  def take_seat
    self.seats_free
    if @seats_free > 0
      @seats_taken += 1
    else
      puts "Нет свободного места в вагоне"
    end
  end

  def seats_free
    @seats_free = @seats - @seats_taken
  end
end