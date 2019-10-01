% Authore:
% Rea Haas.

% spaceship game.
% space ship 
% battle spaceship


% constants:

shot_x_directions([-2,-1,0,1,2]).


	
/*
new impleamentation:
*/

% Todo: put this in the initialization of the game.
board_size(6).  %:-
    % integer(N).
	
% game representation:
pos(Turn, Ender_fleet, Bugs_fleet, Shots, Gui_objects):-
	
	% each X_ships is an array of ship object, which is a list of two arguments:
    % ship = [HP, [X,Y]].	
	
	Ender_fleet = [ender, Ender_action_points, Ender_ships],
	Bugs_fleet = [bugs, Bugs_action_points, Bugs_ships].
	% colusions(Shots, Gui_objects).
	
/*	
initialize_game(Game):-
    initialize_board(Game,Board),
	initialize_resources(Game, Resources).
*/
	

% game flow:


% the game is over when one of the fleet have no more ships. 
% game_over(+Pos).
game_over(pos(Turn, Ender_fleet, Bugs_fleet, Shots, Hits)):-
    ( Ender_fleet = [ender, Action_points, Ships]; 
	  Bugs_fleet = [bugs, Action_points, Ships]
	),
	Ships = [].

% get_shot_initial_location(+Player, +Ship, -Loaction)
% return the initial location of the shot.
get_shot_initial_location(Player, Ship, Ship_loaction):-
    Ship = [_, Ship_loaction].
	
	
% get_shot_direction(+Player, -Direction)
% direction can be one of: [X,Y] : -2 =< X =< 2, Y in {1,-1}.
% this predicat only generate the direction.
% the direction move is explained and calculate in the predicat:
% calculate_shot_filght(+Shot,-Shot1)
get_shot_direction(Player, [X,Y]):-
	(
	 ( Player = ender,
	   Y is 1
	 );
	 ( Player = bugs,
	   Y is -1
	 )
	),
    shot_x_directions(Shot_x_directions),
	member(X,Shot_x_directions).
	

ship_fire_shot(Player, Ship, Shot):-
    % Ship = [HP, Column],
	get_shot_direction(Player, Direction),
	get_shot_initial_location(Player, Ship, Loaction),
	Shot = [Direction, Loaction].

create_shot(Fleet, Fleet1, Shot):-
    Fleet = [Player, Action_points, Ships],  % decode fleet
	
	Action_points > 0,  % make sure there that the player has an action point.
	Action_points1 is Action_points - 1,
	Fleet1 = [Player, Action_points1, Ships],
	
	member(Ship, Ships),
	ship_fire_shot(Player, Ship, Shot).


action_shot(pos(Turn, Ender_fleet, Bugs_fleet, Shots, Hits),pos(Turn, Ender_fleet1, Bugs_fleet1, Shots1, Hits)):-
    (
	 ( Turn = ender,
	   create_shot(Ender_fleet, Ender_fleet1, Shot),
       Bugs_fleet1 = Bugs_fleet
     );
	 ( Turn = bugs,
	   create_shot(Bugs_fleet, Bugs_fleet1, Shot),
	   Ender_fleet1 = Ender_fleet
	 )
	),
	Shots1 = [Shot|Shots].
	%%% note: maybe need to sort the shots to avoid duplication positions.
	
	
action_push_spaceship(Pos,Pos1):-
    %%% need to fill up.
	aaa.


change_player(pos(Turn, Ender_fleet, Bugs_fleet, Shots, Hits), 
              pos(Turn1, Ender_fleet, Bugs_fleet, Shots, Hits)):-         
    ( Turn = ender,
	  Turn1 = bugs
	);
	( Turn = bugs,
	  Turn1 = ender
	).
	
% calculate_shot_filght(+Shot,-Shot1)
% find the new locations for the shot, by it's direction, and current location.
% ender shots go up, while the bugs shots go down.

calculate_shot_filght([[Xd,Yd],[Xl,Yl]],Shot1):-
    Xl1 is Xl + Xd,
	abs(Xd,Abs_Xd),
	Yl1 is Yl + (Yd * (3 - Abs_Xd)),
	Shot1 = [[Xd,Yd], [Xl1,Yl1]].
	

% calculate_shots_flight(+Shots,-Shots1)
% find the new locations for all the shots.
calculate_shots_flight([],[]).

calculate_shots_flight([Shot|Shots_res],[Shot1|Shots_res1]):-
    calculate_shot_filght(Shot,Shot1),
	calculate_shots_flight(Shots_res,Shots_res1).

% update_hps(+Shots1, +Fleet,-Fleet1)
update_hps(Shots, [ender, Action_points, [Ship|Fleet_res] ], [Ship1|Fleet_res1]):-
    Ship = [HP, Column],
	colusions().
        

post_turn_actoin(pos(Turn, Ender_fleet, Bugs_fleet, Shots, GUI), 
                 pos(Turn1, Ender_fleet, Bugs_fleet, Shots1, GUI1)):-
    calculate_shots_flight(Shots,Shots1),
	update_hps(Shots1, Ender_fleet, Ender_fleet1),
	update_hps(Shots1, Bugs_fleet, Bugs_fleet1).
	% build_gui_objects(pos(Turn1, Ender_fleet, Bugs_fleet, Shots1, GUI1)),
	% clean_shots(Shots1,Shots2).


% A move is done by using action points: to fire or move your own ships.

move_use_3_action_point(Pos,Pos2):-
    move_use_2_action_point(Pos,Pos1),
	move_use_1_action_point(Pos1,Pos2).

move_use_2_action_point(Pos,Pos2):-
    move_use_1_action_point(Pos,Pos1),
	move_use_1_action_point(Pos1,Pos2).

% an action point can be use to fire a shot or to push a spaceship.
/* test:
* HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,6]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[],_),move_use_1_action_point(Pos,Pos1).
*/
move_use_1_action_point(Pos,Pos1):-
	action_shot(Pos,Pos1).  %;
	% action_push_spaceship(Pos,Pos1).


% no moves can be perform.
move(Pos,_):-
    game_over(Pos), !, fail.

% General movet hat can be done.
% at each turn, the player can use 1-3 action point.
% move(+Pos,-Pos3)
move(Pos,Pos3):-
    (
	move_use_1_action_point(Pos,Pos1);
	move_use_2_action_point(Pos,Pos1);
	move_use_3_action_point(Pos,Pos1)
	),
	change_player(Pos1,Pos2),
	post_turn_actoin(Pos2,Pos3).


% moves(+Pos, -PosList)
moves(Pos, PosList):-
    ( game_over(Pos), fail;
	  bagof(Pos1,move(Pos,Pos1),PosList)
	).



%%%% Alpha Beta part:


% need to fix the number of arguments.
max_to_move([ender,_,_,_,_]).

min_to_move([bugs,_,_,_,_]).

%% add staticval

%% add alphabeta


