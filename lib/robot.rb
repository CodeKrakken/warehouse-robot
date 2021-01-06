class Robot

  attr_reader :location
  attr_reader :warehouse
  attr_reader :crate

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
    when 'd'
      drop
    else
      error
    end
    
  end

  # private

  def move(direction)
    if allowed?(direction)
      @location[1] += 1 if direction == 'n'
      @location[0] += 1 if direction == 'e'
      @location[0] -= 1 if direction == 'w'
      @location[1] -= 1 if direction == 's'
      @location
    else
      'Cannot move there.'
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
    if @crate
      'Already holding crate.'
    else
      warehouse.crates.each do |crate|
        if crate.location == @location
          warehouse.crates.delete(crate)
          @crate = crate
          return @crate
        else
          return "No crate to grab."
        end
      end
    end
  end

  def drop
    if !@crate
      return 'No crate to drop.'
    elsif !space_is_clear
      return 'Cannot drop crate here.'
    else
      warehouse.crates.push(@crate)
      @crate = nil
      return 'Dropped crate gently.'      
    end
  end

  def space_is_clear
    warehouse.crates.each do |crate|
      crate.location != @location
    end
  end

end