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

#################################################################################
################################### Functions ###################################

func _ready():
	generate_default_input_schemes()
	menu_node = get_tree().root.get_node("MainRoot/UICanvas/Menu")

	DisplayServer.window_set_position(DisplayServer.window_get_position() - (DisplayServer.window_get_size() / 2))
	DisplayServer.window_set_size(DisplayServer.window_get_size() * 2)
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
	menu_node.connect("start_game", Callable(self, "start_game"))
	menu_node.connect("quit_game", Callable(self, "quit_game"))


func is_in_game():
	return game_mode == GameMode.IN_GAME


func start_game():
	load_level("res://Levels/NavigationTesting.tscn")
	game_mode = GameMode.IN_GAME
	update_menu()


func quit_game():
	get_tree().quit()
	

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
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		menu_node.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if Input.is_action_just_pressed("Toggle Fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func get_movement_input():
	var result = Vector2(0, 0)

	if controls_mode == ControlsMode.WASD_MOUSE:
		result = Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Backward")

	return result


func generate_default_input_schemes():
	# WASD + Mouse
	var wasdMouseConfig = ConfigFile.new()
	wasdMouseConfig.set_value("INFO", "Scheme name", "WASD + Mouse")
	wasdMouseConfig.set_value("INFO", "Locked", true)
	wasdMouseConfig.set_value("INFO", "Move with mouse", false)
	wasdMouseConfig.set_value("INFO", "Same button for \"Use\" & \"Fire\"", false)

	wasdMouseConfig.set_value("Keyboard", 		"Move Left", 					KEY_A)
	wasdMouseConfig.set_value("KeyboardAlt",	"Move Left", 					"")
	wasdMouseConfig.set_value("Keyboard", 		"Move Right", 					KEY_D)
	wasdMouseConfig.set_value("KeyboardAlt", 	"Move Right", 					"")
	wasdMouseConfig.set_value("Keyboard",		"Turn Left", 					KEY_LEFT)
	wasdMouseConfig.set_value("Keyboard",	 	"Turn Right", 					KEY_RIGHT)
	wasdMouseConfig.set_value("Keyboard", 		"Move Forward", 				KEY_W)
	wasdMouseConfig.set_value("KeyboardAlt", 	"Move Forward", 				KEY_UP)
	wasdMouseConfig.set_value("Keyboard", 		"Move Backward", 				KEY_S)
	wasdMouseConfig.set_value("KeyboardAlt",	"Move Backward", 				KEY_DOWN)
	wasdMouseConfig.set_value("Mouse",	 		"Fire", 						MOUSE_BUTTON_LEFT)
	wasdMouseConfig.set_value("KeyboardAlt",	"Fire", 						KEY_CTRL)
	wasdMouseConfig.set_value("Mouse", 			"Use", 							MOUSE_BUTTON_RIGHT)
	wasdMouseConfig.set_value("KeyboardAlt",	"Use", 							KEY_E)
	wasdMouseConfig.set_value("Keyboard", 		"Mouse Only - Strafe Mode", 	"")
	wasdMouseConfig.set_value("KeyboardAlt", 	"Mouse Only - Strafe Mode", 	"")
	wasdMouseConfig.set_value("Keyboard",	 	"TTS. Check Goals", 			KEY_1)
	wasdMouseConfig.set_value("KeyboardAlt", 	"TTS. Check Goals", 			KEY_G)
	wasdMouseConfig.set_value("Keyboard",	 	"TTS. Check Health", 			KEY_2)
	wasdMouseConfig.set_value("KeyboardAlt", 	"TTS. Check Health", 			KEY_H)
	wasdMouseConfig.set_value("Keyboard", 		"Cat. Search an exit", 			KEY_C)
	wasdMouseConfig.set_value("KeyboardAlt", 	"Cat. Search an exit", 			"")
	wasdMouseConfig.set_value("Keyboard", 		"Toggle Fullscreen", 			KEY_F11)
	wasdMouseConfig.save("user://control_scheme_wasd_mouse.cfg")

	# Doom style mouse only
	var doomMouseOnlyConfig = ConfigFile.new()
	doomMouseOnlyConfig.set_value("INFO", "Scheme name", "Doom-like mouse only")
	doomMouseOnlyConfig.set_value("INFO", "Locked", true)
	doomMouseOnlyConfig.set_value("INFO", "Move with mouse", true)
	doomMouseOnlyConfig.set_value("INFO", "Same button for \"Use\" & \"Fire\"", false)
	doomMouseOnlyConfig.set_value("INFO", "Double-click strafe for \"use\"", true)

	doomMouseOnlyConfig.set_value("Mouse",	"Fire",					MOUSE_BUTTON_LEFT)
	doomMouseOnlyConfig.set_value("Mouse",	"Use",					MOUSE_BUTTON_RIGHT)
	doomMouseOnlyConfig.set_value("Mouse", 	"Strafe Mode", 			MOUSE_BUTTON_RIGHT)
	doomMouseOnlyConfig.set_value("Mouse", 	"Cat. Search an exit",	MOUSE_BUTTON_MIDDLE)
	doomMouseOnlyConfig.set_value("Keyboard", 	"Toggle Fullscreen", KEY_F11)
	doomMouseOnlyConfig.save("user://control_scheme_doom_like.cfg")

	# Mouse only
	var mouseOnlyConfig = ConfigFile.new()
	mouseOnlyConfig.set_value("INFO", "Scheme name", "Mouse only")
	mouseOnlyConfig.set_value("INFO", "Locked", true)
	mouseOnlyConfig.set_value("INFO", "Move with mouse", true)
	mouseOnlyConfig.set_value("INFO", "Same button for \"Use\" & \"Fire\"", true)
	
	mouseOnlyConfig.set_value("Mouse",	"Fire",					MOUSE_BUTTON_LEFT)
	mouseOnlyConfig.set_value("Mouse",	"Use",					"")
	mouseOnlyConfig.set_value("Mouse", 	"Strafe Mode", 			MOUSE_BUTTON_RIGHT)
	mouseOnlyConfig.set_value("Mouse", 	"Cat. Search an exit",	MOUSE_BUTTON_MIDDLE)
	mouseOnlyConfig.set_value("Keyboard", 	"Toggle Fullscreen", KEY_F11)

	mouseOnlyConfig.save("user://control_scheme_mouse_only.cfg")