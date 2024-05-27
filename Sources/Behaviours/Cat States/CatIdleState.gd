class_name CatIdleState
extends BehaviourState

var cat : Follower
var parent : Node
var player : Node3D
var graphics : AnimatedSprite3D

func _init(_behaviour : Behaviour):
	self.behaviour = _behaviour
	self.state_name = "Idle"

func enter():
	parent = behaviour.behaviour_owner
	cat = parent.get_node("Follower")
	graphics = parent.get_node("Graphics")
	cat.resume()

	player = behaviour.get_tree().get_first_node_in_group(GroupNames.Player)

func update(_delta):
	var player_front = -player.global_transform.basis.z*5 + player.global_position
	if behaviour.global_position.distance_to(player_front) > 3:
		cat.follow_position(player_front)
	var cat_velocity = cat.get_velocity()
	if cat_velocity.x + cat_velocity.z > 0.1:
		graphics.play("walk")
	else:
		graphics.play("idle")

func input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("Cat. Search an exit"):
			find_mushroom()

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

