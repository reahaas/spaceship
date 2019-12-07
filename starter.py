from __future__ import print_function
from pprint import pprint
import time
import format_prolog_output_to_python

from prolog_consult_files import create_prolog_and_consult_files

from Tests.test_move import test_move
from Tests.test_push_ship import test_push_ship

prolog = create_prolog_and_consult_files()


test_push_ship_object = test_push_ship(prolog)
print("push test:\n {0}".format(test_push_ship_object))

test_move(prolog)
