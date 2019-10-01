# spaceship

The roles of the game are:
Goal: 
Destroy all the enemy spaceships. While keep yours alive.

State: build out of this components:
1.	My position: My spaceships’s location and health, my total action points. 
2.	Enemy position, same structure as mine.
3.	Shots map: each shot constructed from position and direction.

Player’s Move in the game: using of action point:
1.	Each action point allow you to perform one shot, or to move one spaceship.
a.	Move a spaceship can be done to left or right.
b.	Shots can have an angle of those types: 3:0, 2:1, 1:2 to both left or right:
-2,-1,0,1,2.

Post move actions:
1.	Shots moves by directions.
2.	If shot hit a spaceship, decrease the hp of that ship by 1 (hit animation).
3.	If two shots hit in the field’ remove both of them from the board (explosive animation). 
4.	Increase the action point of two players by the [number of ships + 1].

A representation of the game can be:
1.	2 dimensional list – each item in the sub list represent a square.
2.	Two lists for each player, and for shots an Asserts roles like: shot(Direction, Location), or list of shots.
a.	Player(Player_1, Action_points , Spaceships).  % Spaceships is a list of object of that  type:
b.	Spaceship(HP, Location)   Location: [X,Y] 
