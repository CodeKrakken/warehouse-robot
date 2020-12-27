class Robot

  attr_reader :location

  def initialize
    @location = [0,0]
  end

  def instruct(instruction)
    case instruction
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
    @location[1] += 1 unless @location[1] >= 5
    return @location
  end

  def move_east
    @location[0] += 1
    return @location
  end

  def move_west
    @location[0] -= 1
    return @location
  end

  def move_south
    @location[1] -= 1 unless @location[1] <= -5
    return @location
  end
end