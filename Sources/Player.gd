extends CharacterBody3D

const SPEED = 10.0

@export var mouse_sensitivity = 0.1
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var root_node
var local_delta = 0


func _ready():
	root_node = get_tree().root.get_child(0)


func _physics_process(delta):
	local_delta = delta
	# Movement
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = root_node.get_movement_input()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	
func _input(event):
	if event is InputEventMouseMotion:
		if !Input.is_action_pressed("Mouse Only - Strafe Mode"):
			rotation.y -= event.get_relative().x * mouse_sensitivity * local_delta