import time

import format_prolog_output_to_python
from pprint import pprint
from prolog_consult_files import create_prolog_and_consult_files


def test_move_use_1_action_point(prolog):
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
        board = format_prolog_output_to_python.convert_prolog_board_to_python_board(case)

        print("board after icon put: {0}".format(board))
        pprint(board)


    print("Moves count is: {i}".format(i=len(test_move_return_list)))


def test_move(prolog):
    test_move_return = prolog.query(
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "move(Pos,Pos1), Pos1=pos(bugs,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
    # "move(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")


    # print("generator prints: {}".format(test_move_return))
    # print("aaaa")
    # i = 1
    # for item in test_move_return:
    #     print("item in generator: {0}".format(item))
    #     print("i = {}".format(i=+1))


    test_move_return_list = list(test_move_return)

    print("list return from move query is: \n{list}".format(list=test_move_return_list))
    print(test_move_return_list)
    for case in test_move_return_list:
        board = format_prolog_output_to_python.convert_prolog_board_to_python_board(case)

        print("board after icon put: {0}".format(board))
        pprint(board)

    print("Moves count is: {i}".format(i=len(test_move_return_list)))
