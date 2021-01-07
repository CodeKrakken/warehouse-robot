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