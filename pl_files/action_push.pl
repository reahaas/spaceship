


:-use_module(pos_definition).
:-use_module(reduce_action_point)

:-module(action_push, [push_spaceship/2, action_push_spaceship/2, in_the_board/1]).

% **** action push ****


% push_spaceship(+Fleet, -Fleet1)
push_spaceship(Fleet, Fleet1):-
    % decode fleet.
	Fleet = [Player, Action_points, Ships],

	% update action points.
	reduce_one_action_point(Action_points, Action_points1),

	% choose a single ship to move.
	select(Ship, Ships, Ships_temp),

	% update the location.
	Ship = [HP, [X,Y]],
	( X1 is X + 1;
	  X1 is X - 1
	),
	in_the_board(X1),
	Ship1 = [HP, [X1,Y]],

	% add the pushed ship back to the Ships list.
    select(Ship1, Ships1, Ships_temp),

	Fleet1 = [Player, Action_points1, Ships1].


% action_push_spaceship(+Pos,-Pos1)
% push one of the player ships one square.
action_push_spaceship(pos(Turn, Ender_fleet, Bugs_fleet, Shots),
                      pos(Turn, Ender_fleet1, Bugs_fleet1, Shots)):-
    (
	 ( Turn = ender,
	   push_spaceship(Ender_fleet, Ender_fleet1),
       Bugs_fleet1 = Bugs_fleet
     );
	 ( Turn = bugs,
	   push_spaceship(Bugs_fleet, Bugs_fleet1),
	   Ender_fleet1 = Ender_fleet
	 )
	).

