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
      allowed?(@north) ? move(@north) : move_error
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
      try_grab
    when 'D'
      try_drop
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

  def try_grab
    return 'Already holding crate.' if @crate
    @crate = @warehouse.crates.find {|crate| crate.location == @location }
    @crate ? grab : grab_error
  end

  def grab
    warehouse.crates.delete(@crate)
    puts "Grabbed crate #{@crate}."
    @crate  
  end

  def grab_error
    puts "No crate to grab."
    "No crate to grab."
  end

  def try_drop
    return 'No crate to drop.' if !@crate
    warehouse.check(@location) ? drop_error : drop
  end

  def drop
    warehouse.crates.push(@crate)
    @crate = nil
    puts 'Dropped crate gently.'
    return 'Dropped crate gently.'
  end

  def drop_error
    puts 'Cannot drop crate here.'
    'Cannot drop crate here.'
  end

  def move_error
    puts 'Cannot move there.'
    'Cannot move there.'
  end

end