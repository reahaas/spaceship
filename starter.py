from __future__ import print_function
from pprint import pprint
import time
import format_prolog_output_to_python

from prolog_consult_files import create_prolog_and_consult_files

from Tests.test_move import test_move_use_1_action_point, test_move
from Tests.test_push_ship import test_push_ship
from Tests.test_alpha_beta import test_alpha_beta
from Tests.test_moves import test_moves


prolog = create_prolog_and_consult_files()

if False:
    test_push_ship_object = test_push_ship(prolog)
    print("push test:\n {0}".format(test_push_ship_object))

# test_move_use_1_action_point(prolog)

test_move(prolog)



# test_alpha_beta(prolog)


