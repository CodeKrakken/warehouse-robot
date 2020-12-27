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
      @location[1] += 1
    when 's'
      @location[1] -= 1
    else
      return
    end
  end

end