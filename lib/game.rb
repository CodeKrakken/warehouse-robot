# frozen_string_literal: true

require_relative 'crate'
require_relative 'warehouse'
require_relative 'robot'

class Game # :nodoc:
  attr_reader :warehouse, :robot, :crate, :crate2

  def initialize
    @warehouse = Warehouse.new
    @robot = Robot.new(@warehouse)
    @crate = Crate.new
    @crate2 = Crate.new
    @warehouse.receive(@crate, 0, 0)
    @warehouse.receive(@crate2, 5, 5)
  end

  def run
    puts "\nCOMMAND THE ROBOT."
    loop do
      instructions = gets.chomp.split(' ')
      instructions.each do |instruction|
        @robot.instruct(instruction)
      end
    end
  end
end

# game = Game.new
# game.run
