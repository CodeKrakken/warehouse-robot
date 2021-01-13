# frozen_string_literal: true

class Crate # :nodoc:
  attr_reader :location

  # attr_accessor :held

  def update(location)
    @location = location # if @held
  end
end
