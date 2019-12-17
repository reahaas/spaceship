% This file contain predicates to get input from the user.

% in each turn, the user will choose a spaceship, and then choose action to perform.



:-module(board_printer, [printmatrix/1]).


test_get_user_move(Pos, Ship_location, Action, Pos1):-


move_ship_one_step
(
      ( Action is move_right,
        move_ship_right(Ship_location, Ship_location1)
      );
      ( Action is move_left,
        move_ship_left(Ship_location, Ship_location1)
      )

    )

get_user_move(Pos, Ship_location, Action, Pos1):-
    Pos = pos(Turn, Ender_fleet, Bugs_fleet, Shots),
    choose_spaceship(Pos, Ship_location, Ship),
    Ship = [HP, Ship_location],
    Ship_location = [X,Y],


