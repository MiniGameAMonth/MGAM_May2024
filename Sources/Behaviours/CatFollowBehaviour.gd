extends Node3D

enum State { IDLE, WALK_TO_MUSHROOM, WALK_TO_EXIT, NEAR_MUSHROOM, NEAR_EXIT }

var state : State = State.IDLE
var targetMushroom : Node3D;

@export var cat : Follower;

var targetRef : WeakRef;

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(GroupNames.Cat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == State.IDLE:
		var mushrooms = get_tree().get_nodes_in_group(GroupNames.Mushrooms)

		if mushrooms.size() > 0:
			var closestMushroom = find_closest(mushrooms)
			set_target_mushroom(closestMushroom)
			state = State.WALK_TO_MUSHROOM
		else:
			state = State.WALK_TO_EXIT

	elif state == State.WALK_TO_MUSHROOM:
		if cat.is_at_target():
			state = State.NEAR_MUSHROOM
		if get_target_mushroom() == null:
			state = State.IDLE

	elif state == State.NEAR_MUSHROOM:
		# Make sounds
		if get_target_mushroom() == null: # Mushroom was picked up
			state = State.IDLE
	elif state == State.NEAR_EXIT:
		# Make sounds?
		pass

func set_target_mushroom(mushroom):
	targetMushroom = mushroom
	targetRef = weakref(mushroom)
	cat.follow(targetMushroom)

func get_target_mushroom():
	if targetRef:
		return targetRef.get_ref()
	return null

func find_closest(mushrooms : Array[Node]):
	if mushrooms.size() == 0:
		return null
	var closest = mushrooms[0].global_position.distance_squared_to(cat.global_position)
	var closestMushroom = mushrooms[0]

	for mushroom in mushrooms:
		var distance = mushroom.global_position.distance_squared_to(cat.global_position)
		if distance < closest:
			closest = distance
			closestMushroom = mushroom

	return closestMushroom
