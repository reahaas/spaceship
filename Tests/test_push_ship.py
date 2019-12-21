
import  format_prolog_output_to_python

def test_push_ship(prolog):
    generator_results = prolog.query("Player = ender,"
                                     " Action_points = 1,"
                                     " Ship = [1, [3,1]], Ships = [Ship],"
                                     " Fleet = [Player, Action_points, Ships],"
                                     " push_spaceship(Fleet, Fleet1), Fleet1 = [_, _, Ships1].")
    generator_results_list = list(generator_results)
    for item in generator_results_list:
        print("in function test_push_ship: {0}".format(item))

    return generator_results


def test_action_push_spaceship(prolog):
    test_action_push_spaceship_return = prolog.query(
        "HP=1, E_ship = [HP,[3,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "action_push_spaceship(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
    generator_results_list = list(test_action_push_spaceship_return)
    for item in generator_results_list:
        print("in function test_action_push_ship: {0}".format(item))


    print("Moves count is: {i}".format(i=len(generator_results_list)))
