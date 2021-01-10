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
      allowed?('n') ? move('n') : 'Cannot move there.'
    when 'e'
      allowed?('e') ? move('e') : 'Cannot move there.'
    when 's'
      allowed?('s') ? move('s') : 'Cannot move there.'
    when 'w'
      allowed?('w') ? move('w') : 'Cannot move there.'
    when 'ne'
      if @location[1] + 1 <= warehouse.dimensions[1]/2 && @location[0] + 1 <= warehouse.dimensions[0]/2
        move('n') && move('e')
      else
        'Cannot move there.'
      end
    when 'sw'
      if (@location[1] - 1).abs <= warehouse.dimensions[1]/2 && (@location[0] - 1).abs <= warehouse.dimensions[0]/2
        move('s') && move('w')
      else
        'Cannot move there.'
      end
    when 'nw'
      if @location[1] + 1 <= warehouse.dimensions[1]/2 && (@location[0] - 1).abs <= warehouse.dimensions[0]/2
        move('n') && move('w')
      else
        'Cannot move there.'
      end
    when 'se'
      if (@location[1] - 1).abs <= warehouse.dimensions[1]/2 && @location[0] + 1 <= warehouse.dimensions[0]/2
        move('s') && move('e')
      else
        'Cannot move there.'
      end
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
    # if allowed?(direction)
      @location[1] += 1 if direction == 'n'
      @location[0] += 1 if direction == 'e'
      @location[0] -= 1 if direction == 'w'
      @location[1] -= 1 if direction == 's'
      @crate.update(@location) if @crate
      @location
    # else
    #   'Cannot move there.'
    # end
  end

  def allowed?(direction)
    return @location[1] + 1 <= warehouse.dimensions[1]/2 if direction == 'n'
    return @location[0] + 1 <= warehouse.dimensions[0]/2 if direction == 'e'
    return (@location[0] - 1).abs <= warehouse.dimensions[0]/2 if direction == 'w'
    return (@location[1] - 1).abs <= warehouse.dimensions[1]/2 if direction == 's'
  end

  def error
    "Invalid instruction."
  end

  def grab
    if @crate
      'Already holding crate.'
    else
      @crate = @warehouse.crates.find {|crate| crate.location == @location }
      unless !@crate
        warehouse.crates.delete(@crate)
        return @crate
      else
        "No crate to grab."
      end
    end
  end

  def drop
    return 'No crate to drop.' if !@crate
    return 'Cannot drop crate here.' if warehouse.check(@location) == true
    warehouse.crates.push(@crate)
    @crate = nil
    return 'Dropped crate gently.'
  end

end