extends Node

enum ControlsMode { WASD_MOUSE, MOUSE_ONLY }

#################################################################################
################################### Variables ###################################

@export var controls_mode = ControlsMode.WASD_MOUSE
var level = null
var local_delta = 0

#################################################################################
################################### Functions ###################################

func _ready():
	scale_window() # Remove this before exporting the game for the web
	load_level("res://Levels/TestLevel.tscn")


func _process(delta):
	pass


func _physics_process(delta):
	local_delta = delta


func scale_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()

	while window_size.x * 2 < screen_size.x and window_size.y * 2 < screen_size.y:
		window_size.x *= 2
		window_size.y *= 2
	
	DisplayServer.window_set_size(window_size)
	center_window()


func load_level(path):
	level = load(path).instantiate()
	add_child(level)


func center_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position((screen_size / 2) - (window_size / 2))



func _input(event):
	if event is InputEventMouseMotion:
		if level:
			if controls_mode == ControlsMode.MOUSE_ONLY:
				if Input.is_action_pressed("Mouse Only - Strafe Mode"):
					level.player.global_position += event.get_relative().x * local_delta * level.player.transform.basis.x

				level.player.global_position += event.get_relative().y * local_delta * level.player.transform.basis.z

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func get_movement_input():
	var result = Vector2(0, 0)

	if controls_mode == ControlsMode.WASD_MOUSE:
		result = Input.get_vector("WASD+Mouse - Move Left", "WASD+Mouse - Move Right", "WASD+Mouse - Move Forward", "WASD+Mouse - Move Backward")

	return result
