class Native
  @@instances = []

  def initialize
    @@instances << self
  end

  def self.all
    @@instances.inspect
  end
end