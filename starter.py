from __future__ import print_function
from pyswip import Prolog
from pprint import pprint
import time

prolog = Prolog()

# load the file:
prolog.consult("spaceship.pl")
prolog.consult("board_printer.pl")

# prolog.assertz("father(michael,john)")
# prolog.assertz("father(michael,gina)")

# list(prolog.query("father(michael,X)")) == [{'X': 'john'}, {'X': 'gina'}]

# for soln in prolog.query("father(X,Y)"):
#     print (soln["X"], "is the father of", soln["Y"])

# i = 1
# for board in prolog.query("HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,12]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]),move(Pos,Pos_list)."):
#     print("index {i} is {board}".format(i=i, board=board))
#     i += 1

# test_return = prolog.query("HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,12]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]), move_use_1_action_point(Pos,Pos1).")

if False:
    test_move_return = prolog.query(
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]], Shots=[], "
        "Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "move_use_1_action_point(Pos,Pos1), Pos1=pos(ender,[ender,1,[E_ship1]], [bugs,2,[B_ship1]],Shots1).")

    test_move_return_list = list(test_move_return)

    # i = 0
    # for board in test_move_return_list:
    #     print("\nboard number is: {0}".format(i))
    #     print(board)

    i = 1
    for board in test_move_return:
        print("\nboard number is: {0}".format(i))
        for element in board:
            print("element is: {0}".format(element))
            if isinstance(element, str):
                print("*** element {0} is a string ***".format(element))
            # for item in element:
            print("\t{element}: {value}".format(element=element, value=board[element]))
        i += 1
        # print("results are: {board}".format(board=board))

# print(test_return)
# michael is the father of john
# michael is the father of gina

BOARD_SIZE = 12

EMPTY_ICON = 0
ENDER_SHIP_ICON = 1
BUGS_SHIP_ICON = 2
SHOT_ICON = 10
ENDER_SHIP_HITED_ICON = ENDER_SHIP_ICON + SHOT_ICON
BUGS_SHIP_HITED_ICON = BUGS_SHIP_ICON + SHOT_ICON


def is_shot_in_location(x, y, shots):
    for shot in shots:
        location = shot[1]
        location_x = location[0]
        location_y = location[1]
        if x is location_x and y is location_y:
            return True
    return False  # no shot found in this location


def is_ship_in_location(x, y, ship):
    location = ship[1]
    location_x = location[0]
    location_y = location[1]
    if x is location_x and y is location_y:
        return True
    return False  # no shot found in this location


def get_icon(x, y, ender_ships, bugs_ships, shots):

    for ship in ender_ships:
        if is_ship_in_location(x, y, ship):
            if is_shot_in_location(x, y, shots):
                return ENDER_SHIP_HITED_ICON
            else:
                return ENDER_SHIP_ICON

    for ship in bugs_ships:
        if is_ship_in_location(x, y, ship):
            if is_shot_in_location(x, y, shots):
                return BUGS_SHIP_HITED_ICON
            else:
                return BUGS_SHIP_ICON

    if x > 1 and x <= BOARD_SIZE:
        if is_shot_in_location(x, y, shots):
            return SHOT_ICON

    return EMPTY_ICON


def print_board(ender_ships, bugs_ships, shots):
    board = [[0 for x in range(BOARD_SIZE)] for y in range(BOARD_SIZE)]
    # [][]  # [BOARD_SIZE][BOARD_SIZE]

    print("empty board: {}".format(board))
    # fill the borad with icons. run from 0 to BOARD_SIZE.
    for i in range(1, BOARD_SIZE+1):
        for j in range(1, BOARD_SIZE+1):
            # in prolog the rows are y, in python the rows are i
            board[i-1][j-1] = get_icon(j, i, ender_ships, bugs_ships, shots)

    return board

def test_move():


    test_move_return = prolog.query(
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "move_use_1_action_point(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
        # "move(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
    test_move_return_list = list(test_move_return)

    for item in test_move_return:
        print("item in generator: {0}".format(item))

    print(test_move_return_list)
    for case in test_move_return_list:
        ender_ships = test_move_return_list[0]["E_ships1"]
        bugs_ships = test_move_return_list[0]["B_ships1"]
        shots = test_move_return_list[0]["Shots1"]
        print("ender_ships: {0}".format(ender_ships))
        print("bugs_ships: {0}".format(bugs_ships))
        print("shots: {0}".format(shots))


    # for item in ender_ships:
    #     print(item)

    board = print_board(ender_ships, bugs_ships, shots)
    print("board after icon put: {0}".format(board))
    pprint(board)

def test_push_ship():
    generator_results = prolog.query("Player = ender,"
                                     " Action_points = 1,"
                                     " Ship = [1, [3,1]], Ships = [Ship],"
                                     " Fleet = [Player, Action_points, Ships],"
                                     " push_spaceship(Fleet, Fleet1), Fleet1 = [_, _, Ships1].")
    generator_results_list = list(generator_results)
    for item in generator_results_list:
        print("in function test_push_ship: {0}".format(item))
    return generator_results



test_push_ship_object = test_push_ship()
print("push test:\n {0}".format(test_push_ship_object))

test_move()
