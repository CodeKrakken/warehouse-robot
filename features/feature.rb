# get files

require './lib/robot'
require './lib/warehouse'
require './lib/crate'

#create instances

warehouse = Warehouse.new
robot = Robot.new(warehouse)
crate = Crate.new(1, 1)
crate_2 = Crate.new(0, 0)

# display instances and attributes

crate
crate_2
crate.location
crate_2.location
robot
robot.location

# move robot

robot.instruct('e')
robot.instruct('w')
robot.instruct('n')
robot.instruct('s')

# edgecase

robot.instruct('b')

# boundary test

5.times { robot.instruct('n') }
robot.location
robot.instruct('n')
10.times { robot.instruct('s') }
robot.location
robot.instruct('s')
robot.location
robot.instruct('g')

# robot grab function

warehouse.receive(crate)
robot.instruct('g')
robot.instruct('e')
6.times { robot.instruct('n') }
robot.location
robot.instruct('g')
robot.crate
