class Robot

  attr_reader :location

  def initialize
    @location = [0,0]
  end

  def instruct(instruction)
    case instruction
    when 'e'
      @location[0] += 1
    when 'w'
      @location[0] -= 1
    when 'n'
      move_north
    when 's'
      @location[1] -= 1
    else
      return
    end
  end

  def move_north
    @location[1] += 1 unless @location[1] >= 5
    return @location[1]
  end

end