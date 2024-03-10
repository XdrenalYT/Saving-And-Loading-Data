extends Resource
class_name GoalData


@export var goals = []


func add_goal(g):
	goals.append(g)
	


func remove_goal(g):
	goals.erase(g)

