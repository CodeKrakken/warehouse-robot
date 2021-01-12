class Warehouse

  attr_reader :dimensions
  attr_reader :crates

  def initialize
    @dimensions = 10,10
    @crates = []
  end

  def receive(crate, x, y)
    crate.update([x, y])
    return 'Crate already in warehouse.' if @crates.include?(crate)
    return 'Position occupied.' if occupied(crate.location) == true
    @crates.push(crate)
  end

  def occupied(location)
    crates.each do |crate|
      return true if crate.location == location
    end
  end

end