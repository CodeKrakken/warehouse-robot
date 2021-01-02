class Robot

  attr_reader :location

  def initialize
    @location = [0,0]
  end

  def instruct(instruction)
    @instruction = instruction  
    if allowed? 
      @location[1] += 1 if @instruction == 'n'
      @location[0] += 1 if @instruction == 'e'
      @location[0] -= 1 if @instruction == 'w'
      @location[1] -= 1 if @instruction == 's'
      @location
    else
      error
    end
  end

  private

  def allowed?
    return @location[1] < 5 if @instruction == 'n'
    return @location[1] > -5 if @instruction == 's'
    return @location[0] < 5 if @instruction == 'e'
    return @location[0] > -5 if @instruction == 'w'
  end

  def error
    "Invalid instruction."
  end
end