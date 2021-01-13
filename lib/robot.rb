# frozen_string_literal: true

class Robot # :nodoc:
  attr_reader :location, :warehouse, :crate

  def initialize(warehouse)
    @warehouse = warehouse
    @location = [0, 0]
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
      respond('Invalid instruction.')
    end
  end

  private

  def respond(response)
    print response.to_s
    puts ''
    response
  end

  def try_move(directions)
    directions.each do |direction|
      return respond('Cannot move there.') unless
      @location[direction[1]].send(direction[0], 1).abs <= warehouse.dimensions[direction[1]] / 2
    end
    move(directions)
  end

  def move(directions)
    directions.each { |direction| @location[direction[1]] = @location[direction[1]].send(direction[0], 1) }
    @crate&.update(@location.dup)
    respond([@location[0], @location[1]])
  end

  def try_grab
    return respond('Already holding crate.') if @crate

    @crate = @warehouse.crates.find { |crate| crate.location == @location }
    @crate ? grab : respond('No crate to grab.')
  end

  def grab
    warehouse.crates.delete(@crate)
    respond("Grabbed crate #{@crate}.")
  end

  def try_drop
    return respond('No crate to drop.') unless @crate

    warehouse.occupied(@location) == true ? respond('Cannot drop crate here.') : drop
  end

  def drop
    warehouse.crates.push(@crate)
    @crate = nil
    respond('Dropped crate gently.')
  end
end
