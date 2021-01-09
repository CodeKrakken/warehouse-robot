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
    when 'ne'
        move('n')
        move('e')
    when 'sw'
      if allowed?
        move('s')
        move('w')
      else
        'Cannot move there.'
      end
    when 'nw'
      move('n')
      move('w')
    when 'se'
      move('s')
      move('e')
    when 'g'
      grab
    when 'd'
      drop
    else
      error
    end
    
  end

  private

  def move(direction)
    if allowed?
      @location[1] += 1 if direction == 'n'
      @location[0] += 1 if direction == 'e'
      @location[0] -= 1 if direction == 'w'
      @location[1] -= 1 if direction == 's'
      @crate.update(@location) if @crate
      @location
    else
      'Cannot move there.'
    end
  end

  def allowed?
    (@location[1].abs < @warehouse.dimensions[1]/2 && @location[0].abs < @warehouse.dimensions[0]/2)
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