require_relative 'crate'
require_relative 'warehouse'
require_relative 'robot'

class Game

  attr_reader :warehouse
  attr_reader :robot
  attr_reader :crate
  attr_reader :crate_2

  def initialize
    @warehouse = Warehouse.new
    @robot = Robot.new(@warehouse)
    @crate = Crate.new
    @crate_2 = Crate.new
    @warehouse.receive(@crate, 0, 0)
    @warehouse.receive(@crate, 5, 5)
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