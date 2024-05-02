class_name Follower
extends CharacterBody3D

@export var followTarget : Node3D;
@export var speed : float;
@export var stopAtDistance : float = 0;

@export var lookAtTarget : bool = true;
@export var lookAtSpeed : float = 1;

@onready var agent = $NavigationAgent3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followTarget != null:
		follow(followTarget)

	var nextPosition = agent.get_next_path_position()
	if nextPosition != null:
		move_to_position(nextPosition)
		if lookAtTarget:
			look_at_position(nextPosition, delta)

func move_to_position(pos : Vector3):
	var distance = global_position.distance_to(pos)

	if distance < stopAtDistance + 0.01:
		velocity = Vector3.ZERO
	else:
		velocity = global_position.direction_to(pos) * speed

	move_and_slide()

func look_at_position(pos : Vector3, delta):
	var y_rot = global_rotation.y;
	var direction = global_position.direction_to(pos)
	y_rot = lerp_angle(y_rot, atan2(-direction.x, -direction.z), delta*lookAtSpeed)
	global_rotation.y = y_rot

func follow(target : Node3D):
	agent.target_position = target.global_transform.origin
