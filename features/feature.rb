# get files

require './lib/robot'
require './lib/warehouse'
require './lib/crate'

#create instances

warehouse = Warehouse.new
robot = Robot.new(warehouse)
crate = Crate.new(0, 0)
crate_2 = Crate.new(5, 5)

# display instances

crate
crate_2
robot

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
robot.location
10.times { robot.instruct('s') }
robot.location
robot.instruct('s')
robot.location
5.times { robot.instruct('w') }
robot.location
robot.instruct('w')
robot.location
10.times { robot.instruct('e') }
robot.location
robot.instruct('e')
robot.location

# warehouse receive crates

warehouse.crates
warehouse.receive(crate)
warehouse.receive(crate_2)
warehouse.receive(crate_2)
warehouse.crates

# robot grab function

robot.instruct('g')
5.times { robot.instruct('e') }
10.times { robot.instruct('n') }
robot.location
warehouse.crates
robot.instruct('g')
robot.crate
warehouse.crates
5.times { robot.instruct('s') }
5.times { robot.instruct('w') }
robot.location
crate_2.location
robot.crate
robot.instruct('g')

# robot drop function

robot.crate
robot.instruct('d')
robot.crate
robot.instruct('n')
robot.instruct('d')
crate_2.location