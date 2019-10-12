from __future__ import print_function
from pyswip import Prolog

prolog = Prolog()

# load the file:
prolog.consult("spaceship.pl")

prolog.assertz("father(michael,john)")
prolog.assertz("father(michael,gina)")

list(prolog.query("father(michael,X)")) == [{'X': 'john'}, {'X': 'gina'}]

for soln in prolog.query("father(X,Y)"):
    print (soln["X"], "is the father of", soln["Y"])

i = 1
for board in prolog.query("HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,12]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]),move(Pos,Pos_list)."):
    print("index {i} is {board}".format(i=i, board=board))
    i += 1

test_return = prolog.query("HP=1, E_ship = [HP,[3,1]],B_ship=[HP,[1,12]],Pos=pos(ender,[ender,2,[E_ship]], [bugs,2,[B_ship]],[]), move_use_1_action_point(Pos,Pos_list).")

for board in test_return:
    print("results are: {board}".format(board=board))

# michael is the father of john
# michael is the father of gina
