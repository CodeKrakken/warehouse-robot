class Warehouse

  attr_reader :dimensions
  attr_reader :crates

  def initialize
    @dimensions = 10,10
    @crates = []
  end

  def receive(crate, x, y)
    return 'Crate already in warehouse.' if @crates.include?(crate)
    return 'Position occupied.' if check(crate.location) == true
    crate.update([x, y])
    @crates.push(crate)
  end

  def check(location)
    crates.each do |crate|
      return true if crate.location == location
    end
  end

end