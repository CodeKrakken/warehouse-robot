class Crate

  attr_reader :location

  def initialize(x, y)
    @location = [x, y]
  end

  def update(location)
    @location = location
  end
end