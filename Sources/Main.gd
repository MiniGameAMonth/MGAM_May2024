extends Node

enum ControlsMode { WASD_MOUSE, MOUSE_ONLY }
enum GameMode { MENU, IN_GAME }

#################################################################################
################################### Variables ###################################

@export var controls_mode = ControlsMode.WASD_MOUSE
var game_mode = GameMode.MENU
var level = null
var local_delta = 0
var menu_node = null
var hud_node = null

#################################################################################
################################### Functions ###################################

func _ready():
	menu_node = get_tree().root.get_node("MainRoot/UICanvas/Menu")
	hud_node = get_tree().root.get_node("MainRoot/UICanvas/HUD")

	scale_window() # Remove this before exporting the game for the web
	subscribe_to_menu_events()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if game_mode == GameMode.MENU:
			game_mode = GameMode.IN_GAME
		else:
			game_mode = GameMode.MENU

		update_menu()


func _physics_process(delta):
	local_delta = delta


func subscribe_to_menu_events():	
	menu_node.connect("start_game",Callable(self,"start_game"))


func is_in_game():
	return game_mode == GameMode.IN_GAME


func scale_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()

	while window_size.x * 2 < screen_size.x and window_size.y * 2 < screen_size.y:
		window_size.x *= 2
		window_size.y *= 2
	
	DisplayServer.window_set_size(window_size)
	center_window()


func start_game():
	load_level("res://Levels/TestLevel.tscn")
	game_mode = GameMode.IN_GAME
	update_menu()


func load_level(path):
	level = load(path).instantiate()
	add_child(level)


func change_level(path):
	if level != null:
		level.queue_free()

	load_level(path)


func update_menu():
	if game_mode == GameMode.MENU:
		menu_node.visible = true
		hud_node.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		menu_node.visible = false
		hud_node.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func center_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position((screen_size / 2) - (window_size / 2))


func _input(event):
	pass
	# if event is InputEventMouseMotion:
	# 	if level:
	# 		if controls_mode == ControlsMode.MOUSE_ONLY:
	# 			if Input.is_action_pressed("Mouse Only - Strafe Mode"):
	# 				level.player.global_position += event.get_relative().x * local_delta * level.player.transform.basis.x

	# 			level.player.global_position += event.get_relative().y * local_delta * level.player.transform.basis.z

	# if event is InputEventMouseButton:
	# 	if level and game_mode == GameMode.IN_GAME:
	# 		if event.button_index == MOUSE_BUTTON_LEFT:
	# 			if !Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
	# 				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func get_movement_input():
	var result = Vector2(0, 0)

	if controls_mode == ControlsMode.WASD_MOUSE:
		result = Input.get_vector("WASD+Mouse - Move Left", "WASD+Mouse - Move Right", "WASD+Mouse - Move Forward", "WASD+Mouse - Move Backward")

	return result
