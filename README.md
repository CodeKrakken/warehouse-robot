# warehouse_robot

Modelling the actions of a hardworking warehouse robot, very much of the ilk of T.O.M. from TV's Bertha.

We have installed a robot in our warehouse. This is the mechanism by which it can be controlled. All of the commands to the robot consist of a single capital letter and different commands are dilineated by whitespace.

## Installation

```
git clone https://github.com/CodeKrakken/warehouse-robot.git
cd warehouse-robot
bundle install
```

## Usage

Program runs in the command line. Start it with `ruby rungame.rb`. Initially there is one crate in the north-east corner of the warehouse and one in the centre.

* The robot moves along a 10x10 grid in the warehouse, and will not move outside its confines.
* The robot will not grab a crate if it already holding one
* The robot will not grab a crate if there is not one present
* The robot will not drop a crate on another crate!
* Anything but the following list returns an error.
* `N`  - move north
* `W`  - move west
* `E`  - move east
* `S`  - move south
* `NW` - move north-west
* `NE` - move north-east
* `SW` - move south-west
* `SE` - move south-east
* `G`  - grab crate
* `D`  - drop crate

### Example command sequences

* The command sequence: `N E S W` will move the robot in a full square, returning it to where it started.
* If the robot starts in the south-west corner of the warehouse then the following commands will move it to the middle of the warehouse.

`N E N E N E N E`

## Testing

This was built with TDD. To run the tests:

* `rspec` for the unit tests
* `irb features/feature.rb` for the feature tests

## Screenshot

![warehouse_robot](https://user-images.githubusercontent.com/52076323/104477361-e9377000-55b8-11eb-8726-64282a37cbdf.png)
