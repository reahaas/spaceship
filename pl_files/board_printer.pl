% print the board:

:-module(board_printer, [printmatrix/1]).

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
