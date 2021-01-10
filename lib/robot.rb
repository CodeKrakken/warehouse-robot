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
      allowed?(:+, 1) ? move(:+, 1) : 'Cannot move there.'
    when 'e'
      allowed?(:+, 0) ? move(:+, 0) : 'Cannot move there.'
    when 's'
      allowed?(:-, 1) ? move(:-, 1) : 'Cannot move there.'
    when 'w'
      allowed?(:-, 0) ? move(:-, 0) : 'Cannot move there.'
    when 'ne'
      allowed?(:+, 1) && allowed?(:+, 0) ? move(:+, 1) && move(:+, 0) : 'Cannot move there.'
    when 'sw'
      allowed?(:-, 1) && allowed?(:-, 0) ? move(:-, 1) && move(:-, 0) : 'Cannot move there.'
    when 'nw'
      allowed?(:+, 1) && allowed?(:-, 0) ? move(:+, 1) && move(:-, 0) : 'Cannot move there.'
    when 'se'
      allowed?(:-, 1) && allowed?(:+, 0) ? move(:-, 1) && move(:+, 0) : 'Cannot move there.'
    when 'g'
      grab
    when 'd'
      drop
    else
      error
    end
    
  end

  # private

  def move(operator, index)
    @location[index] = @location[index].send(operator, 1)
    @crate.update(@location) if @crate
    @location
  end

  def allowed?(operator=nil, index=nil)
    return @location[index].send(operator, 1).abs <= warehouse.dimensions[index]/2
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