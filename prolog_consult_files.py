from pyswip import Prolog


def create_prolog_and_consult_files():
    prolog = Prolog()

    # load the file:
    prolog.consult("spaceship.pl")
    prolog.consult("board_printer.pl")

    return prolog
