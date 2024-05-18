extends CharacterBody3D

const SPEED = 10.0

@export var mouse_sensitivity = 0.1
@export var mouse_double_click_speed = 200
var mouse_click_last_time = 0
var mouse_click_last_button = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var local_delta = 0
@export var enable_input = true
@onready var interactions : InteractionArea = $InteractionArea
var interaction : Interactable
@onready var weapon : Weapon = $Weapon
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var hud : PlayerHUD = $CanvasLayer/PlayerHud

var menu_node = null


func _ready():
	#root_node = get_tree().root.get_child(0)

	add_to_group("Player")

	menu_node = get_node("/root/MainRoot/UICanvas/Menu")
	interactions.connect("on_interaction", on_interact)
	interactions.connect("on_interaction_end", on_interact_end)


func on_interact(interactable: Interactable):
	interaction = interactable


func on_interact_end(_interactable: Interactable):
	_interactable.stop_interact(self)
	interaction = null
	pass


func _physics_process(delta):
	local_delta = delta	

	if Main.is_in_game():
		# Movement
		if not is_on_floor():
			velocity.y -= gravity * delta

		var input_dir = Main.get_movement_input()
		if not enable_input:
			input_dir = Vector2.ZERO

		var direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y)

		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

	
func _input(event):
	if event is InputEventMouseMotion and enable_input:
		if !Input.is_action_pressed("Strafe Mode"):
			rotation.y -= event.get_relative().x * mouse_sensitivity * local_delta

	if Input.is_action_just_pressed("Fire") and enable_input:		
		if weapon.can_shoot():
			hud.play_wand_animation("shoot", Callable(weapon, "shoot"))

	if interaction and event is InputEventMouseButton:
		if Input.is_action_just_pressed("Use"):
			interaction.interact(self)
		if Input.is_action_just_released("Use"):
			interaction.stop_interact(self)

	# Detect mouse double click
	if event is InputEventMouseButton and enable_input:
		if (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) and event.pressed:
			if Time.get_ticks_msec() - mouse_click_last_time < mouse_double_click_speed:
				if menu_node.get_active_controls_scheme().config.get_value("INFO", "Double-click strafe for \"use\"", false):
					print("use")
					Input.action_press("Use")

			mouse_click_last_time = Time.get_ticks_msec()
