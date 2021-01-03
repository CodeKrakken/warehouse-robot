class Warehouse

  attr_reader :dimensions
  attr_reader :crates

  def initialize
    @dimensions = 10,10
    @crates = []
  end

  def receive(crate)
    @crates.push(crate)
  end

end