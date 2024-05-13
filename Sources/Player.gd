extends CharacterBody3D

const SPEED = 10.0

@export var mouse_sensitivity = 0.1
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var root_node
var local_delta = 0


@onready var interactions : InteractionArea = $InteractionArea
@onready var weapon : Weapon = $Weapon

func _ready():
	root_node = get_tree().root.get_child(0)
	interactions.connect("on_interaction", on_interact)
	interactions.connect("on_interaction_end", on_interact_end)

func on_interact(interactable: Interactable):
	#for now pick everything up, later we will check for player input (or not)
	interactable.interact(self)

func on_interact_end(_interactable: Interactable):
	#to be used for gui in case we check for player input
	pass

func _physics_process(delta):
	local_delta = delta
	

	if Main.is_in_game():
		# Movement
		if not is_on_floor():
			velocity.y -= gravity * delta

		var input_dir = Main.get_movement_input()
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

	if Input.is_action_just_pressed("Fire"):		
		weapon.shoot()