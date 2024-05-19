extends Behaviour

enum State { IDLE, WALK_TO_MUSHROOM, WAIT_FOR_PLAYER, WALK_TO_EXIT, NEAR_MUSHROOM, NEAR_EXIT }

var lastState : State = State.IDLE
var state : State = State.IDLE
var targetMushroom : Node3D;

@export var cat : Follower;

@export var graphics : AnimatedSprite3D
@export var interactionArea : Interactable

@export var lineOfSight : LineOfSight3D

var player : Node3D = null

func _ready():
	add_to_group(GroupNames.Cat)
	lineOfSight.set_origin_offset(Vector3(0, 1, -1.5))
	change_state(CatIdleState.new(self))


func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group(GroupNames.Player)
		if player == null:
			return
		else:
			lineOfSight.set_target(player)

	super._process(_delta)
