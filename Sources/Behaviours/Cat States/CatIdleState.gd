class_name CatIdleState
extends BehaviourState

var cat : Follower
var parent : Node

func _init(_behaviour : Behaviour):
	self.behaviour = _behaviour
	self.state_name = "Idle"

func enter():
	parent = behaviour.behaviour_owner
	cat = parent.get_node("Follower")
	cat.stop()

	var mushrooms = behaviour.get_tree().get_nodes_in_group(GroupNames.Mushrooms)

	if mushrooms.size() > 0:
		var closestMushroom = find_closest(mushrooms)
		behaviour.change_state(CatFindMushroomState.new(behaviour, closestMushroom))
	else:
		behaviour.change_state(CatFindExitState.new(behaviour))

func find_closest(mushrooms : Array[Node]):
	if mushrooms.size() == 0:
		return null
	var closest = mushrooms[0].global_position.distance_squared_to(cat.get_parent().global_position)
	var closestMushroom = mushrooms[0]

	for mushroom in mushrooms:
		var distance = mushroom.global_position.distance_squared_to(cat.get_parent().global_position)
		if distance < closest:
			closest = distance
			closestMushroom = mushroom

	return closestMushroom

