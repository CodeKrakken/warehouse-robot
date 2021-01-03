class Robot

  attr_reader :location
  attr_reader :warehouse

  def initialize(warehouse)
    @warehouse = warehouse
    @location = [0,0]
  end

  def instruct(instruction)
    case instruction
    when 'n'
      move('n')
    when 'e'
      move('e')
    when 's'
      move('s')
    when 'w'
      move('w')
    when 'g'
      grab
    else
      error
    end
    
  end

  private

  def move(direction)
    if allowed?(direction)
      @location[1] += 1 if direction == 'n'
      @location[0] += 1 if direction == 'e'
      @location[0] -= 1 if direction == 'w'
      @location[1] -= 1 if direction == 's'
      @location
    else
      error
    end
  end

  def allowed?(direction)
    return @location[1] < 5 if direction == 'n'
    return @location[1] > -5 if direction == 's'
    return @location[0] < 5 if direction == 'e'
    return @location[0] > -5 if direction == 'w'
  end

  def error
    "Invalid instruction."
  end

  def grab
    crate? ? "Grabbing crate." : "No crate to grab."
  end

  def crate?
    @warehouse.crates.length > 0
  end
end