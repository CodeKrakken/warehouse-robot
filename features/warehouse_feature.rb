require './lib/warehouse'
require './lib/crate'
require './lib/robot'
warehouse = Warehouse.new
warehouse
crate = Crate.new(0, 0)
crate
robot = Robot.new(Warehouse)
robot
warehouse.crates
warehouse.receive(crate)
warehouse.crates