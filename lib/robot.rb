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
      try_move([@north])
    when 'E'
      try_move([@east])
    when 'S'
      try_move([@south])
    when 'W'
      try_move([@west])
    when 'NE'
      try_move([@north, @east])
    when 'SW'
      try_move([@south, @west])
    when 'NW'
      try_move([@north, @west])
    when 'SE'
      try_move([@south, @east])
    when 'G'
      try_grab
    when 'D'
      try_drop
    else
      instruction_error
    end
    
  end

  private

  def instruction_error
    puts "Invalid instruction."
    return "Invalid instruction."
  end

  def try_move(directions)
    directions.each do |direction|
      return move_error unless @location[direction[1]].send(direction[0], 1).abs <= warehouse.dimensions[direction[1]]/2
    end
    move(directions)
  end

  def move(directions)
    directions.each do |direction|
      @location[direction[1]] = @location[direction[1]].send(direction[0], 1)
    end
    @crate.update(@location) if @crate
    puts @location
    @location
  end

  def move_error
    puts 'Cannot move there.'
    'Cannot move there.'
  end

  def try_grab
    return holding_crate_error if @crate
    @crate = @warehouse.crates.find {|crate| crate.location == @location }
    @crate ? grab : grab_error
  end

  def grab
    warehouse.crates.delete(@crate)
    puts "Grabbed crate #{@crate}."
    @crate  
  end

  def holding_crate_error
    puts 'Already holding crate.'
    return 'Already holding crate.'
  end

  def grab_error
    puts "No crate to grab."
    "No crate to grab."
  end

  def try_drop
    return no_crate_error if !@crate
    warehouse.occupied(@location) == true ? drop_error : drop
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

  def no_crate_error
    puts 'No crate to drop.'
    return 'No crate to drop.'
  end
end