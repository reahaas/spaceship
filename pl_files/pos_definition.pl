


:-module(pos_definition, [pos/4, board_size/1, in_the_board/1]).


% game representation:
pos(Turn, Ender_fleet, Bugs_fleet, Shots):-  %%%  , Gui_objects):-

	% Turn is the name of the player.
	% it can be one of: {ender, bugs}.

	% Fleets look like this:
	Ender_fleet = [ender, Ender_action_points, Ender_ships],
	Bugs_fleet = [bugs, Bugs_action_points, Bugs_ships].

    % Action_points is a non negative integer.

	% each X_ships is an array of ship object, which is a list of two arguments:
    % ship = [HP, [X,Y]].

    % Shots is an array of Shot objects:
	% Shot = [Direction, Location] ,
	% Direction = [Xd,Yd], Location = [Xl,Yl].

    % Gui_objects is the full board representation.
	% it's calculate by the lists: Ender_fleet, Bugs_fleet, Shots.

board_size(12).  %:-
    % integer(N).


in_the_board(X):-
    X >= 1,
	board_size(N),
	X =< N.

