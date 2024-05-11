extends Panel

enum ActionType { KEYBOARD, MOUSE, GAMEPAD_BUTTON, GAMEPAD_AXIS }
enum State { NORMAL, WAITING_KEY, WAITING_KEY_ALT }

@export var action_name : String
@export var action_key : String
@export var action_key_alt : String
@export_flags("Keyboard", "Mouse", "Gamepad Button", "Gamepad Axis") var allowed_action_types 


func setup():
	if action_name == "":
		printerr("Missing action name")
		return

	$Label.text = action_name


func set_input(key, type, button):
	var input_name = OS.get_keycode_string(key)

	if type == ActionType.KEYBOARD:

		# Find icon for key, if not found - use text
		var icon = load("res://Assets/Images/Menu/Inputs/" + input_name + ".png")

		if icon != null:
			button.icon = icon
			button.text = ""
		else:
			button.icon = null
			button.text = input_name
		
		button.flat = false

	if type == ActionType.MOUSE:
		button.flat = true

		if key == MOUSE_BUTTON_LEFT:
			button.text = ""
			button.icon = load("res://Assets/Images/Menu/Inputs/LMB.png")
		elif key == MOUSE_BUTTON_RIGHT:
			button.text = ""
			button.icon = load("res://Assets/Images/Menu/Inputs/RMB.png")
		elif key == MOUSE_BUTTON_MIDDLE:
			button.text = ""
			button.icon = load("res://Assets/Images/Menu/Inputs/MMB.png")
		elif key == MOUSE_BUTTON_WHEEL_UP:
			button.text = ""
			button.icon = load("res://Assets/Images/Menu/Inputs/ScrollUp.png")
		elif key == MOUSE_BUTTON_WHEEL_DOWN:
			button.text = ""
			button.icon = load("res://Assets/Images/Menu/Inputs/ScrollDown.png")
		else:
			button.text = input_name
			

func set_primary_input(key, type):
	set_input(key, type, $Button)	


func set_secondary_input(key, type):
	set_input(key, type, $AlternateButton)
