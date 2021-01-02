class Robot

  attr_reader :location

  def initialize
    @location = [0,0]
  end

  def instruct(instruction)
    @instruction = instruction
    case @instruction
    when 'e'
      move_east
    when 'w'
      move_west
    when 'n'
      move_north
    when 's'
      move_south
    else
      return
    end
  end

  def move_north
    if allowed?
      @location[1] += 1 
      @location
    else
      error
    end
  end

  def move_east
    if allowed?
      @location[0] += 1
      @location
    else
      error
    end
  end

  def move_west
    if allowed?
      @location[0] -= 1
      @location
    else
      error
    end
  end

  def move_south
    if allowed?
      @location[1] -= 1
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
    "Cannot move there."
  end
end