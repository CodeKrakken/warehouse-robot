# get files

require './lib/robot'
require './lib/warehouse'
require './lib/crate'

#create instances

warehouse = Warehouse.new
robot = Robot.new(warehouse)
crate = Crate.new
crate_2 = Crate.new

# display instances

crate
crate_2
robot