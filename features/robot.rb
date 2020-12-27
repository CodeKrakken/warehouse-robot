require './lib/robot'
robot = Robot.new
robot
robot.location
robot.instruct('e')
robot.location
robot.instruct('w')
robot.location
robot.instruct('n')
robot.location
robot.instruct('s')
robot.location
robot.instruct('b')
5.times { robot.instruct('n') }
robot.location
robot.instruct('n')
10.times { robot.instruct('s') }
robot.location
robot.instruct('s')