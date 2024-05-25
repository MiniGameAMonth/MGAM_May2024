class_name Follower
extends Node

@export var followTarget : Node3D;
@export var speed : float;
@export var stopAtDistance : float = 0;

@export var lookAtTarget : bool = true;
@export var lookAtSpeed : float = 1;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var enableGravity : bool = true;

@export var agent : NavigationAgent3D
@export var characterBody : CharacterBody3D
var speedMultiplier = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	if agent == null:
		push_error("Follower of ", get_parent().name, " has no NavigationAgent3D.")
	agent.target_desired_distance = stopAtDistance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if enableGravity and not characterBody.is_on_floor():
		characterBody.velocity.y -= gravity * delta
	else:
		characterBody.velocity.y = 0
		
	if is_instance_valid(followTarget):
		follow_position(followTarget.global_position)

	var nextPosition = agent.get_next_path_position()
	if nextPosition != null:
		move_to_position(nextPosition)
		if lookAtTarget and agent.target_position != characterBody.global_position:
			look_at_position(nextPosition, delta)

func path_direction():
	var pos = agent.get_next_path_position()
	return characterBody.global_position.direction_to(pos)

func stop():
	speedMultiplier = 0

func resume():
	speedMultiplier = 1

func move_to_position(pos : Vector3):
	if not is_at_target():
		var newVelocity = characterBody.global_position.direction_to(pos) * speed
		newVelocity.y = characterBody.velocity.y
		characterBody.velocity = newVelocity * speedMultiplier
	else:
		characterBody.velocity.x = 0
		characterBody.velocity.z = 0

	characterBody.move_and_slide()

func look_at_position(pos : Vector3, delta):
	var y_rot = characterBody.global_rotation.y;
	var direction = characterBody.global_position.direction_to(pos)
	y_rot = lerp_angle(y_rot, atan2(-direction.x, -direction.z), delta*lookAtSpeed)
	characterBody.global_rotation.y = y_rot

func follow(target : Node3D):
	if is_instance_valid(target):
		followTarget = target
	else:
		agent.target_position = characterBody.global_position

func follow_position(target : Vector3):
	agent.target_position = target

func is_at_target():
	return agent.distance_to_target() < stopAtDistance

func dist_to_target():
	return agent.distance_to_target()
