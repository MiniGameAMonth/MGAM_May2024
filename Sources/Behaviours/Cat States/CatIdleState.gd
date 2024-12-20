class_name CatIdleState
extends BehaviourState

var cat : Follower
var parent : Node
var player : Player
var graphics : AnimatedSprite3D

func _init(_behaviour : Behaviour):
	self.behaviour = _behaviour
	self.state_name = "Idle"

func enter():
	parent = behaviour.behaviour_owner
	cat = parent.get_node("Follower")
	graphics = parent.get_node("Graphics")
	cat.resume()

	player = behaviour.get_tree().get_first_node_in_group(GroupNames.Players)
	player.ask_guide_star.connect(find_mushroom)

	var player_front = -player.global_transform.basis.z*7 + player.global_position
	cat.follow_position(player_front)

func update(_delta):
	var player_front = -player.global_transform.basis.z*7 + player.global_position
	if behaviour.global_position.distance_to(player_front) > 7:
		cat.follow_position(player_front)

	var cat_velocity = cat.get_velocity()
	if abs(cat_velocity.x) + abs(cat_velocity.z) > 0.01:
		graphics.play("walk")
	else:
		graphics.play("idle")

func exit():
	player.ask_guide_star.disconnect(find_mushroom)

func find_mushroom():
	var mushrooms = behaviour.get_tree().get_nodes_in_group(GroupNames.Mushrooms)

	if mushrooms.size() > 0:
		var closestMushroom = find_closest(mushrooms)
		behaviour.change_state(CatFindMushroomState.new(behaviour, closestMushroom))
	else:
		behaviour.change_state(CatFindExitState.new(behaviour))

func find_closest(mushrooms : Array[Node]):
	if mushrooms == null or mushrooms.size() == 0:
		return null

	var closest = mushrooms[0].global_position.distance_squared_to(cat.get_parent().global_position)
	var closestMushroom = mushrooms[0]

	for mushroom in mushrooms:
		var distance = mushroom.global_position.distance_squared_to(cat.get_parent().global_position)
		if distance < closest:
			closest = distance
			closestMushroom = mushroom

	return closestMushroom

