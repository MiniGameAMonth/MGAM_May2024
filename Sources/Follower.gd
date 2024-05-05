class_name Follower
extends CharacterBody3D

@export var followTarget : Node3D;
@export var speed : float;
@export var stopAtDistance : float = 0;

@export var lookAtTarget : bool = true;
@export var lookAtSpeed : float = 1;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var enableGravity : bool = true;

@onready var agent = $NavigationAgent3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	agent.target_desired_distance = stopAtDistance
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enableGravity and not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		
	if followTarget != null:
		follow(followTarget)

	var nextPosition = agent.get_next_path_position()
	if nextPosition != null:
		move_to_position(nextPosition)
		if lookAtTarget:
			look_at_position(nextPosition, delta)

func move_to_position(pos : Vector3):
	if not is_at_target():
		var newVelocity = global_position.direction_to(pos) * speed
		newVelocity.y = velocity.y
		velocity = newVelocity
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func look_at_position(pos : Vector3, delta):
	var y_rot = global_rotation.y;
	var direction = global_position.direction_to(pos)
	y_rot = lerp_angle(y_rot, atan2(-direction.x, -direction.z), delta*lookAtSpeed)
	global_rotation.y = y_rot

func follow(target : Node3D):
	agent.target_position = target.global_transform.origin

func is_at_target():
	return agent.distance_to_target() < stopAtDistance

func dist_to_target():
	return agent.distance_to_target()
