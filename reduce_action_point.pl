
:-module(reduce_action_point, [reduce_one_action_point/2]).

reduce_one_action_point(Action_points, Action_points1):-
    Action_points > 0,  % make sure that the player has an action point.
	Action_points1 is Action_points - 1.