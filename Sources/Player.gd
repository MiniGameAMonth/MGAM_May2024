class_name Player
extends CharacterBody3D

signal call_star()
signal ask_guide_star()

var SPEED = 15.0

@export var mouse_sensitivity = 0.1
@export var mouse_double_click_speed = 200
var mouse_click_last_time = 0
var mouse_click_last_button = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var local_delta = 0
@export var enable_input = true
@export var block_movement = false

@export var ask_guide_star_voiceline : AudioStream
@export var collected_all_mushrooms_voiceline : AudioStream
@export var good_kitten_voiceline : AudioStream

@export var footsteps : Array[FootstepsPlayer3D]
var footsteps_delays : Array[float]


@onready var interactions : InteractionArea3D = $InteractionArea
var interaction : Interactable
@onready var weapon : Weapon = $Weapon
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var hud : PlayerHUD = $CanvasLayer/PlayerHud
@onready var voicelinePlayer : VoicelinePlayer = $VoicelinePlayer


var menu_node = null

func low_health():
	SPEED = 5
	for i in range(footsteps.size()):
		footsteps[i].set_loop_delay(footsteps_delays[i] + 1)

func high_health():
	SPEED = 15
	for i in range(footsteps.size()):
		footsteps[i].set_loop_delay(footsteps_delays[i])

func _ready():
	menu_node = get_node("/root/MainRoot/UICanvas/Menu")
	#root_node = get_tree().root.get_child(0)
	footsteps_delays = []
	for i in range(footsteps.size()):
		footsteps_delays.append(footsteps[i].loop_delay)

	add_to_group("Player")

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
		if not enable_input or block_movement:
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
		if weapon.can_attack():
			hud.play_wand_animation("shoot", Callable(weapon, "try_attack"))

	if interaction and event is InputEventMouseButton:
		if Input.is_action_just_pressed("Use"):
			interaction.interact(self)
		if Input.is_action_just_released("Use"):
			interaction.stop_interact(self)

	if event is InputEventKey:
		if Input.is_action_just_pressed("Cat. Search an exit"):
			ask_guide_star.emit()

	# Detect mouse double click
	if event is InputEventMouseButton and enable_input:
		if (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) and event.pressed:
			if Time.get_ticks_msec() - mouse_click_last_time < mouse_double_click_speed:
				if menu_node.get_active_controls_scheme().config.get_value("INFO", "Double-click strafe for \"use\"", false):
					Input.action_press("Use")

			mouse_click_last_time = Time.get_ticks_msec()


func is_looking_at(object: Node3D) -> bool:
	var direction_to_object = global_position.direction_to(object.global_position)
	var threshold = 0.95
	return -direction_to_object.dot(global_transform.basis.z) > threshold
