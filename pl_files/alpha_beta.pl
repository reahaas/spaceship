

module(alpha_beta, [alphabeta/5]).

:-use_module(pos_definition).
% :-use_module(spaceship).



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
	length(Shots, N_shots),
	Val is ( 10 * ( Ender_N_ships - Bugs_N_ships ) + N_shots).


%% add alphabeta

% Code from the book:
% http://media.pearsoncmg.com/intl/ema/ema_uk_he_bratko_prolog_3/prolog/ch22/fig22_5.txt
% The alpha-beta algorithm

% test:
% Pos = [first,2,4,5,6],alphabeta( Pos, -1000, 1000, GoodPos, Val).
% Pos = [first,3,5,7,9],alphabeta( Pos, -1000, 1000, GoodPos, Val).

%%%%%%%%%%%%%%%%%%%%% Rea's code %%%%%%%%%%%%

% The order of the predicats for the improved (with assert) alphabeta algoritem is important!
% first check if the staticval is already in the db,
% if not, calculate it,
% or in the trivial case, return it in the simplest way.

% Read from the db, check if the value already exists.
% if it's already exists, then use it and save it back.
alphabeta( Pos, Alpha, Beta, GoodPos, Val)  :-
    ( retract(pos_staticval(Pos,GoodPos,Val)),!,        % the cut is here to prevent calculation of the value, since it already exists.
	  assert(pos_staticval(Pos,GoodPos,Val))
	).

% The value of Pos not exists, and need to be calculate:
alphabeta( Pos, Alpha, Beta, GoodPos, Val)  :-
    ( moves( Pos, PosList), !,
      boundedbest( PosList, Alpha, Beta, GoodPos, Val),
      assert(pos_staticval(Pos,GoodPos,Val))            % Save the calculated value into the db
    ).

% The trivial case, no possible moves from Pos:
alphabeta( Pos, Alpha, Beta, GoodPos, Val)  :-
   	staticval( Pos, Val).                              % Static value of Pos

%%%%%%%%%%%%%%%%%%%%% End's of Rea's code %%%

boundedbest( [Pos | PosList], Alpha, Beta, GoodPos, GoodVal)  :-
    alphabeta( Pos, Alpha, Beta, _, Val),
    goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal).

goodenough( [], _, _, Pos, Val, Pos, Val)  :-  !.    % No other candidate

goodenough( _, Alpha, Beta, Pos, Val, Pos, Val)  :-
    min_to_move( Pos), Val > Beta, !                   % Maximizer attained upper bound
    ;
    max_to_move( Pos), Val < Alpha, !.                 % Minimizer attained lower bound

goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal)  :-
    newbounds( Alpha, Beta, Pos, Val, NewAlpha, NewBeta),    % Refine bounds
    boundedbest( PosList, NewAlpha, NewBeta, Pos1, Val1),
    betterof( Pos, Val, Pos1, Val1, GoodPos, GoodVal).

newbounds( Alpha, Beta, Pos, Val, Val, Beta)  :-
    min_to_move( Pos), Val > Alpha, !.                 % Maximizer increased lower bound

newbounds( Alpha, Beta, Pos, Val, Alpha, Val)  :-
   max_to_move( Pos), Val < Beta, !.                 % Minimizer decreased upper bound

newbounds( Alpha, Beta, _, _, Alpha, Beta).          % Otherwise bounds unchanged

betterof( Pos, Val, Pos1, Val1, Pos, Val)  :-        % Pos better than Pos1
    min_to_move( Pos), Val > Val1, !
    ;
    max_to_move( Pos), Val < Val1, !.

betterof( _, _, Pos1, Val1, Pos1, Val1).             % Otherwise Pos1 better


