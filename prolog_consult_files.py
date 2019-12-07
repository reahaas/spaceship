from pyswip import Prolog


def create_prolog_and_consult_files():
    prolog = Prolog()

    # load the file:
    prolog.consult("pos_definition.pl")
    prolog.consult("reduce_action_point.pl")
    prolog.consult("action_push.pl")
    prolog.consult("board_printer.pl")
    prolog.consult("spaceship.pl")
    # prolog.consult("")
    # prolog.consult("")




    return prolog
