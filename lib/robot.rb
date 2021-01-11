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
    when 'N'
      allowed?(@north) ? move(@north) : 'Cannot move there.'
    when 'E'
      allowed?(@east) ? move(@east) : 'Cannot move there.'
    when 'S'
      allowed?(@south) ? move(@south) : 'Cannot move there.'
    when 'W'
      allowed?(@west) ? move(@west) : 'Cannot move there.'
    when 'NE'
      allowed?(@north) && allowed?(@east) ? move(@north) && move(@east) : 'Cannot move there.'
    when 'SW'
      allowed?(@south) && allowed?(@west) ? move(@south) && move(@west) : 'Cannot move there.'
    when 'NW'
      allowed?(@north) && allowed?(@west) ? move(@north) && move(@west) : 'Cannot move there.'
    when 'SE'
      allowed?(@south) && allowed?(@east) ? move(@south) && move(@east) : 'Cannot move there.'
    when 'G'
      grab
    when 'D'
      drop
    else
      "Invalid instruction."
    end
    
  end

  private

  def move(operator_index)
    @location[operator_index[1]] = @location[operator_index[1]].send(operator_index[0], 1)
    @crate.update(@location) if @crate
    puts @location
    @location
  end

  def allowed?(operator_index)
    return @location[operator_index[1]].send(operator_index[0], 1).abs <= warehouse.dimensions[operator_index[1]]/2
  end

  def grab
    return 'Already holding crate.' if @crate
    @crate = @warehouse.crates.find {|crate| crate.location == @location }
    @crate ? warehouse.crates.delete(@crate) && @crate : "No crate to grab."  
  end

  def drop
    return 'No crate to drop.' if !@crate
    return 'Cannot drop crate here.' if warehouse.check(@location) == true
    warehouse.crates.push(@crate)
    @crate = nil
    puts 'Dropped crate gently.'
    return 'Dropped crate gently.'
  end

end