from __future__ import print_function
from pprint import pprint
import time
import format_prolog_output_to_python

from prolog_consult_files import create_prolog_and_consult_files

from Tests.test_move import test_move
from Tests.test_push_ship import test_push_ship

prolog = create_prolog_and_consult_files()



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








test_push_ship_object = test_push_ship(prolog)
print("push test:\n {0}".format(test_push_ship_object))

test_move(prolog)
