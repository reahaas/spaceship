


def test_post_turn_action(prolog):
    test_post_turn_action = prolog.query(
        "HP=1, E_ship = [HP,[4,1]], B_ship=[HP,[1,12]],"
        "E_ships = [E_ship], B_ships = [B_ship],"
        "Shots=[], "
        "Pos=pos(ender,[ender,1,[E_ship]], [bugs,2,[B_ship]],Shots),"
        "post_turn_action(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
    # "move(Pos,Pos1), Pos1=pos(ender,[ender,1,E_ships1], [bugs,2,B_ships1],Shots1).")
    test_post_turn_action_list = list(test_post_turn_action)

    for item in test_post_turn_action_list:
        print("item in generator: {0}".format(item))
