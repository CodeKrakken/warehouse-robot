# frozen_string_literal: true

# get files

require './lib/robot'
require './lib/warehouse'
require './lib/crate'
require 'pry'

# create instances

warehouse = Warehouse.new
robot = Robot.new(warehouse)
crate = Crate.new
crate2 = Crate.new
crate3 = Crate.new

# display instances

crate
crate2
crate3
robot

# warehouse receive crates

warehouse.crates
warehouse.receive(crate, 0, 0)
warehouse.receive(crate2, 5, 5)
warehouse.receive(crate2, 5, 5)
warehouse.receive(crate3, 5, 5)
warehouse.crates

# move robot

robot.instruct('E')
robot.instruct('W')
robot.instruct('N')
robot.instruct('S')
robot.instruct('NE')
robot.instruct('SW')
robot.instruct('NW')
robot.instruct('SE')

# edgecase

robot.instruct('B')

# boundary test

5.times { robot.instruct('N') }
robot.location
robot.instruct('N')
robot.instruct('NE')
robot.location
5.times { robot.instruct('E') }
5.times { robot.instruct('S') }
robot.location
robot.instruct('E')
robot.instruct('SE')
robot.location
5.times { robot.instruct('S') }
5.times { robot.instruct('W') }
robot.location
robot.instruct('S')
robot.instruct('SW')
robot.location
5.times { robot.instruct('W') }
5.times { robot.instruct('N') }
robot.location
robot.instruct('W')
robot.instruct('NW')
robot.location

# robot grab function

robot.instruct('G')
10.times { robot.instruct('E') }
5.times { robot.instruct('N') }
robot.location
warehouse.crates
robot.instruct('G')
robot.crate
warehouse.crates
5.times { robot.instruct('S') }
5.times { robot.instruct('W') }
robot.location
crate2.location
robot.crate
robot.instruct('G')

# robot drop function

robot.crate
robot.instruct('D')
robot.crate
robot.instruct('N')
robot.instruct('D')
crate2.location
robot.crate
robot.instruct('S')
crate2.location
