class Robot

  attr_reader :location
  attr_reader :warehouse
  attr_reader :crate

  def initialize(warehouse)
    @warehouse = warehouse
    @location = [0,0]
    @north = [:+, 1]
    @south = [:-, 1]
    @east  = [:+, 0]
    @west  = [:-, 0]
  end

  def instruct(instruction)
    case instruction
    when 'n'
      allowed?(@north) ? move(@north) : 'Cannot move there.'
    when 'e'
      allowed?(@east) ? move(@east) : 'Cannot move there.'
    when 's'
      allowed?(@south) ? move(@south) : 'Cannot move there.'
    when 'w'
      allowed?(@west) ? move(@west) : 'Cannot move there.'
    when 'ne'
      allowed?(@north) && allowed?(@east) ? move(@north) && move(@east) : 'Cannot move there.'
    when 'sw'
      allowed?(@south) && allowed?(@west) ? move(@south) && move(@west) : 'Cannot move there.'
    when 'nw'
      allowed?(@north) && allowed?(@west) ? move(@north) && move(@west) : 'Cannot move there.'
    when 'se'
      allowed?(@south) && allowed?(@east) ? move(@south) && move(@east) : 'Cannot move there.'
    when 'g'
      grab
    when 'd'
      drop
    else
      error
    end
    
  end

  # private

  def move(operator_index)
    @location[operator_index[1]] = @location[operator_index[1]].send(operator_index[0], 1)
    @crate.update(@location) if @crate
    @location
  end

  def allowed?(array)
    return @location[array[1]].send(array[0], 1).abs <= warehouse.dimensions[array[1]]/2
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