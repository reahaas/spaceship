import format_prolog_output_to_python
from pprint import pprint


def test_alpha_beta(prolog):

    HP = "HP=1"


    test_alpha_beta = prolog.query(
        "Ender=ender, Bugs=bugs,"
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(Ender,[Ender,2,[E_ship]], [Bugs,2,[B_ship]],Shots),"
        "alphabeta(Pos, -1000, 1000, GoodPos, Val), GoodPos=pos(Bugs, Enders_fleet1, Bugs_fleet1, Shots1),"
        "Enders_fleet1=[Ender,1,E_ships1],  Bugs_fleet1=[Bugs,2,B_ships1]")

    test_alpha_beta_return_list = list(test_alpha_beta)

    good_pos = test_alpha_beta_return_list[0]

    pprint(good_pos)

    good_pos_board = format_prolog_output_to_python.convert_prolog_board_to_python_board(good_pos)

    print(good_pos_board)
    pprint(good_pos_board)

    return good_pos_board

