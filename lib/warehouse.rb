# frozen_string_literal: true

class Warehouse # :nodoc:
  attr_reader :dimensions, :crates

  def initialize
    @dimensions = 10, 10
    @crates = []
  end

  def receive(crate, x_axis, y_axis)
    crate.update([x_axis, y_axis])
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
