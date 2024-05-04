extends Node

enum State { IDLE, WALK_TO_MUSHROOM, WALK_TO_EXIT, NEAR_MUSHROOM, NEAR_EXIT }

var state : State = State.IDLE
var targetMushroom : Node3D;

@export var cat : Follower;

var targetRef : WeakRef;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == State.IDLE:
		var mushrooms = get_tree().get_nodes_in_group(GroupNames.Mushrooms)
		if mushrooms.size() > 0:
			set_target_mushroom(mushrooms[0]) # TODO: Find closest mushroom
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
