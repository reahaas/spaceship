

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
