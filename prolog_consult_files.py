from pyswip import Prolog


def create_prolog_and_consult_files():
    prolog = Prolog()

    pl_dir = "pl_files"
    # load the file:
    prolog.consult("{}/pos_definition.pl".format(pl_dir))
    prolog.consult("{}/reduce_action_point.pl".format(pl_dir))
    prolog.consult("{}/action_push.pl".format(pl_dir))
    prolog.consult("{}/board_printer.pl".format(pl_dir))
    prolog.consult("{}/alpha_beta.pl".format(pl_dir))
    prolog.consult("{}/spaceship.pl".format(pl_dir))
    # prolog.consult("")

    return prolog
