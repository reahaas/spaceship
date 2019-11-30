import format_prolog_output_to_python
from pprint import pprint
from prolog_consult_files import create_prolog_and_consult_files

def test_move(prolog):

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

    board = format_prolog_output_to_python.print_board(ender_ships, bugs_ships, shots)
    print("board after icon put: {0}".format(board))
    pprint(board)