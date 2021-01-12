class Crate

  attr_reader :location
  # attr_accessor :held

  def update(location)
    @location = location # if @held
  end
end