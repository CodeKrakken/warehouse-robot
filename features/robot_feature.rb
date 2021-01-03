require './lib/robot'
require './lib/warehouse'
robot = Robot.new(Warehouse)
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