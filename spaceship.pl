% Authore:
% Rea Haas.

% spaceship game.
% space ship 
% battle spaceship



%%%


% constants:

% shots can move straghit or diadonal, in this steps: -2:1, -1:2, 0:3, 1:2, 2:1
shot_x_directions([-2,-1,0,1,2]).


	
/*
new impleamentation:
*/

% Todo: put this in the initialization of the game.
board_size(12).  %:-
    % integer(N).
	
% game representation:
pos(Turn, Ender_fleet, Bugs_fleet, Shots):-  %%%  , Gui_objects):-
	
	% Turn is the name of the player. 
	% it can be one of: {ender, bugs}.
	
	% Fleets look like this:
	Ender_fleet = [ender, Ender_action_points, Ender_ships],
	Bugs_fleet = [bugs, Bugs_action_points, Bugs_ships].
	
	% each X_ships is an array of ship object, which is a list of two arguments:
    % ship = [HP, [X,Y]].	

    % Shots is an array of Shot objects:
	% Shot = [Direction, Location] , 
	% Direction = [Xd,Yd], Location = [Xl,Yl].

    % Gui_objects is the full board representation.
	% it's calculate by the lists: Ender_fleet, Bugs_fleet, Shots.

/*	
initialize_game(Game):-
    initialize_board(Game,Board),
	initialize_resources(Game, Resources).
*/
	


% game flow:


% the game is over when one of the fleet have no more ships. 
% game_over(+Pos).
game_over(pos(Turn, Ender_fleet, Bugs_fleet, Shots)):-
    ( Ender_fleet = [ender, Action_points, Ships]; 
	  Bugs_fleet = [bugs, Action_points, Ships]
	),
	Ships = [].

% get_shot_initial_location(+Ship, -Loaction)
% return the initial location of the shot.
get_shot_initial_location(Ship, Ship_loaction):-
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
	get_shot_initial_location(Ship, Loaction),
	Shot = [Direction, Loaction].

reduce_one_action_point(Action_points, Action_points1):-
    Action_points > 0,  % make sure there that the player has an action point.
	Action_points1 is Action_points - 1.

create_shot(Fleet, Fleet1, Shot):-
    Fleet = [Player, Action_points, Ships],  % decode fleet
	
	reduce_one_action_point(Action_points, Action_points1),
	Fleet1 = [Player, Action_points1, Ships],
	
	member(Ship, Ships),
	ship_fire_shot(Player, Ship, Shot).


action_shot(pos(Turn, Ender_fleet, Bugs_fleet, Shots),
            pos(Turn, Ender_fleet1, Bugs_fleet1, Shots1)):-
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
	
in_the_board(X):-
    X >= 1,
	board_size(N),
	X =< N.
	
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
	

change_player(pos(Turn, Ender_fleet, Bugs_fleet, Shots), 
              pos(Turn1, Ender_fleet, Bugs_fleet, Shots)):-         
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


% remove all the shots that exceded the borders of the board.
% this action is done after all the calculation of hits and shots movments,
% that the reason to have a week inequality.
% clean_out_of_board_shots(+Shots, -Shots1).
clean_out_of_board_shots([],[]).
clean_out_of_board_shots([Shot|Shots_res], Shots_res):-
	Shot = [Direction, [X,Y]],
	board_size(N),
	( Y =< 1 ; Y >= N ), !.
	
clean_out_of_board_shots([Shot|Shots_res], [Shot|Shots_res1]):-
	clean_out_of_board_shots(Shots_res, Shots_res1).

/*
% remove all the shots that colusions with one another.
% clean_colusion_shots(+Shots1, -Shots2).
clean_colusion_shots([],[]).
clean_colusion_shots(Shots1, Shots2):-
*/


% clean_shots(+Shots, -Shots1).
clean_shots([],[]).
clean_shots(Shots, Shots1):-
    clean_out_of_board_shots(Shots, Shots1).
	% clean_colusion_shots(Shots1, Shots2). % not supported yet.
	
    



% count_hits(+Loaction, +Shots, -Count)
count_hits(Loaction, [], 0 ).
count_hits(Loaction, [Shot|Shots_res], Count):-
    Shot = [Direction, Loaction], !,  % Shot hit the Location.
	count_hits(Loaction, Shots_res, Count1),
	Count is Count1 + 1 .

count_hits(Loaction, [Shot|Shots_res], Count):-  % shot didnt hit Location.
    count_hits(Loaction, Shots_res, Count).

% update_hps(+Shots1, +Ships, -Ships1)
update_hps(Shots, [], []):- 
    !.  

update_hps(Shots, [Ship|Ships_res], Ships1):-  
    Ship = [HP, Loaction],
	count_hits(Loaction, Shots, Count),
	HP1 is HP - Count,
	update_hps(Shots, Ships_res, Ships_res1),  
    (
	 % a ship reach zero HP, which means it destroyed.
	 ( HP1 =< 0, !,
	   Ships1 = Ships_res1
	 );
	 (
	   Ship1 = [HP1, Loaction], 
	   Ships1 = [Ship1|Ships_res1]	 
	 )
	).


/* test:
Pos2 = board_size(N), pos(bugs, [ender, 0, [[1, [1, 1]]]], [bugs, 2, [[1, [1, N]]]], []), post_turn_actoin(Pos2,Pos3).
*/
% post_turn_actoin(+Pos,-Pos1)
post_turn_actoin(pos(Turn, Ender_fleet, Bugs_fleet, Shots), 
                 pos(Turn, Ender_fleet1, Bugs_fleet1, Shots2) ):-
	calculate_shots_flight(Shots,Shots1),
	
	% gui object need to be before the update_hps, to have also destroyed spaceships.
	% build_gui_objects(pos(Turn1, Ender_fleet, Bugs_fleet, Shots1), GUI),
	
	Ender_fleet = [ender, Action_points_ender, Ender_ships],
	update_hps(Shots1, Ender_ships, Ender_ships1),
	Ender_fleet1 = [ender, Action_points_ender, Ender_ships1],
	
	Bugs_fleet = [bugs, Action_points_bugs, Bugs_ships],
	update_hps(Shots1, Bugs_ships, Bugs_ships1),
	Bugs_fleet1 = [bugs, Action_points_bugs, Bugs_ships1],
	
	clean_shots(Shots1,Shots2).


% A move is done by using action points: to fire or move your own ships.

move_use_3_action_point(Pos,Pos2):-
    move_use_2_action_point(Pos,Pos1),
	move_use_1_action_point(Pos1,Pos2).

move_use_2_action_point(Pos,Pos2):-
    move_use_1_action_point(Pos,Pos1),
	move_use_1_action_point(Pos1,Pos2).

% an action point can be use to fire a shot or to push a spaceship.
/* test:
* HP=1, E_ship = [HP,[3,1]], board_size(N), B_ship=[HP,[1,N]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]),move_use_1_action_point(Pos,Pos1).
*/
move_use_1_action_point(Pos,Pos1):-
	action_shot(Pos,Pos1);
	action_push_spaceship(Pos,Pos1).


% no moves can be perform.
move(Pos,_):-
    game_over(Pos), !, fail.

% General movet hat can be done.
% at each turn, the player can use 1-3 action point.
/* test:
HP=1, E_ship = [HP,[3,1]],board_size(N),B_ship=[HP,[1,N]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]),move(Pos,Pos1).
*/
% move(+Pos,-Pos3)
move(Pos,Pos3):-
    (
	move_use_1_action_point(Pos,Pos1);
	move_use_2_action_point(Pos,Pos1)  %;
	% move_use_3_action_point(Pos,Pos1)
	),
	change_player(Pos1,Pos2),
	post_turn_actoin(Pos2,Pos3),
	
	% print the board:
	nl, nl, printmatrix(Pos3),
	
	staticval(Pos3, Val),
	nl, nl, write('The value of the next Pos is:'),
	write(Val).

% print the board:

:-use_module(library(clpfd)).

printedge(X, Y, Symbol) :-
    ( 
	 (nonvar(Symbol),!, write(Symbol));
	 write("0")
	), write(" ").

/*
printedge(X, Y, Symbol) :-    graph(X,Y), write(Symbol), write(" ").
printedge(X,Y) :- \+ graph(X,Y), write("0 ").
*/


printmatrix(pos(Turn, Ender_fleet, Bugs_fleet, Shots)) :-
    (
	board_size(N),
	Y in 1..N,
	indomain(Y), 
	nl,
    X in 1..N,
	indomain(X),
	
	Ender_fleet = [ender, Action_points_ender, Ender_ships],
	Bugs_fleet = [bugs, Action_points_bugs, Bugs_ships],
	
	% 'e' for ender ship, 'b' for bugs ship, 's' for shot, empty square '0'.
	% bug: double object on the same square make double prints.
	(
	 (member([ _, [X,Y] ], Ender_ships), Symbol = 'e');
	 (member([ _, [X,Y] ], Bugs_ships), Symbol = 'b');
	 (member([ Direction,[X,Y] ], Shots), Symbol = 's');
	 
	 % not efficeant! this is a patch, it should use cut but it didnt worked.
	 (   
	   not( member([ _, [X,Y] ], Ender_ships) ),
	   not( member([ _, [X,Y] ], Bugs_ships) ),
	   not( member([ Direction,[X,Y] ], Shots) )
	 )
	),
	
	printedge(X,Y,Symbol),
    fail 
	);
	true.


% moves(+Pos, -PosList)
/* test
notrace,HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,12]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]),moves(Pos,Pos_list).
*/
moves(Pos, PosList):-
    ( game_over(Pos), fail;
	  bagof(Pos1,move(Pos,Pos1),PosList)
	).



%%%% Alpha Beta part:


% need to fix the number of arguments.
max_to_move(pos(ender, Ender_fleet, Bugs_fleet, Shots)).

min_to_move(pos(bugs, Ender_fleet, Bugs_fleet, Shots)).

%% add staticval

staticval(Pos, Val):-
    Pos = pos(Turn, Ender_fleet, Bugs_fleet, Shots),
	Bugs_fleet = [], Val = 1000, !.

staticval(Pos, Val):-
    Pos = pos(Turn, Ender_fleet, Bugs_fleet, Shots),
	Ender_fleet = [], Val = -1000, !.
	
staticval(Pos, Val):-
    Pos = pos(Turn, Ender_fleet, Bugs_fleet, Shots),
	Ender_fleet = [ender, Ender_action_points, Ender_ships],
	Bugs_fleet = [bugs, Bugs_action_points, Bugs_ships],
	length(Ender_ships, Ender_N_ships),
	length(Bugs_ships, Bugs_N_ships),
	Val is ( 10 * ( Ender_N_ships - Bugs_N_ships ) ).


%% add alphabeta


