class Robot

  attr_reader :location

  def initialize
    @location = [0,0]
  end

  def instruct(instruction)
    @location[0] += 1 if instruction = 'e'
  end

  def e
    @location[0] = @location[0] + 1
  end

end