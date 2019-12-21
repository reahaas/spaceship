import format_prolog_output_to_python
from pprint import pprint

def test_alpha_beta(prolog):

    test_alpha_beta = prolog.query(
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "alphabeta(Pos, -1000, 1000, GoodPos, Val), GoodPos=pos(bugs,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
        # "move(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")

    print(test_alpha_beta)

    for item in test_alpha_beta:
        print(item)

    # test_alpha_beta_return_list = list(test_alpha_beta)
    #
    # print(test_alpha_beta_return_list)

    #
    # for item in test_alpha_beta:
    #     print("item in generator: {0}".format(item))
    #
    # print(test_move_return_list)
    # for case in test_move_return_list:
    #     board = format_prolog_output_to_python.convert_prolog_board_to_python_board(case)
    #
    #     print("board after icon put: {0}".format(board))
    #     pprint(board)
