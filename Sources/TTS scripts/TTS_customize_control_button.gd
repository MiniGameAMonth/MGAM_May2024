extends TTS_Button_Attachment
class_name TTS_customize_control_button_attachment
##UI attachment. Use to add TTS to buttons of the keybind customization menu

##The object containing the CustomControlsActionKey
@export var custom_control_action_key : CustomControlsActionKey

##Check, if this button is for the secondary keybind
@export var secondary_keybind : bool = false

var action_name : String
var keybind_name : String

func _ready():	
	action_name = custom_control_action_key.action_name + "..."
	keybind_name = get_keybind_name()

	button.mouse_entered.connect(_on_mouse_entered)
	button.button_up.connect(_on_button_up)
	button.gui_input.connect(_on_keyboard_input)
	button.draw.connect(update_keybind_name)

func get_keybind_name() -> String:
	if !secondary_keybind:
		if custom_control_action_key.action_key_type == 0: #keyboard input
			return get_keycode_primary()
		
		elif custom_control_action_key.action_key_type == 1: #mouse input
			if custom_control_action_key.action_key < 0:
				return "Primary keybind not set"
			else:
				return get_mouse_keybind_name()	

	if custom_control_action_key.action_key_alt_type == 0: #keyboard input
		return get_keycode_secondary()
	
	elif custom_control_action_key.action_key_alt_type == 1: #mouse input
		if custom_control_action_key.action_key_alt < 0:
			return "Secondary keybind not set"
		else:			
			return get_mouse_keybind_name()
	
	return "This input is not from a keyborad or mouse and is not supported."	
	
func _on_button_up():
	TTS.say_phrase("You are changing the keybind for, " + action_name)

#Called when a new keybind is set
func update_keybind_name():
	check_for_changes()
	
func warn_user_of_change():
	TTS.say_phrase("You changed the keybind to, " + keybind_name)

func check_for_changes():	
	var new_keybind = get_keybind_name()

	if new_keybind != keybind_name:
		keybind_name = new_keybind
		warn_user_of_change()
	else:
		return

func get_mouse_keybind_name() -> String:
	match custom_control_action_key.action_key:

		MOUSE_BUTTON_LEFT:
			return "Left Mouse Button"
		MOUSE_BUTTON_RIGHT:
			return "Right Mouse Button"
		MOUSE_BUTTON_MIDDLE:
			return "Middle Mouse Button"
		MOUSE_BUTTON_WHEEL_UP:
			return "Mouse Wheel Up"
		MOUSE_BUTTON_WHEEL_DOWN:
			return "Mouse Wheel Down"
		_:
			return "This mouse button is not supported."

func get_keycode_primary() -> String:
	if custom_control_action_key.action_key < 0:
		return "Primary keybind not set"
	else:
		return OS.get_keycode_string(custom_control_action_key.action_key)

func get_keycode_secondary() -> String:
	if custom_control_action_key.action_key_alt < 0:
		return "Secondary keybind not set"
	else:			
		return OS.get_keycode_string(custom_control_action_key.action_key_alt)

func _on_mouse_entered():
	TTS.say_phrase(action_name + "..." + keybind_name)
