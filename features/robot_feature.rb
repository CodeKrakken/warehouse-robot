require './lib/robot'
require './lib/warehouse'
require './lib/crate'
warehouse = Warehouse.new
robot = Robot.new(warehouse)
robot
robot.location
robot.instruct('e')
robot.instruct('w')
robot.instruct('n')
robot.instruct('s')
robot.instruct('b')
5.times { robot.instruct('n') }
robot.location
robot.instruct('n')
10.times { robot.instruct('s') }
robot.location
robot.instruct('s')
robot.location
robot.instruct('g')
crate = Crate.new(1,1)
warehouse.receive(crate)
robot.instruct('g')
robot.instruct('e')
6.times { robot.instruct('n') }
robot.location
robot.instruct('g')