extends Node
class_name TTS_Button_Attachment
##UI attachment. Use to add TTS to checkboxes and normal buttons

##Button that needs to be read out by the TTS
@export var button: Button

##Use this if the button has no text, can be used to add additional information. THIS IS GOING TO BE READ OUT AFTER THE BUTTON'S TEXT
@export var alternate_text: String

##The TTS node on this UI
@export var TTS_node: TTS

var TTS_text: String
var is_Toggle: bool = false
var toggle_state: bool = false

func _ready():
	if TTS_node == null:
		printerr("TTS node not set")
		return
	
	TTS_text = button.text

	if button.toggle_mode != false:
		is_Toggle = true
		toggle_state = button.button_pressed		
		button.toggled.connect(toggled)

	button.mouse_entered.connect(_on_mouse_entered)
	button.button_up.connect(_on_button_up)
	button.gui_input.connect(_on_keyboard_input)	

func _on_mouse_entered():
	if is_Toggle:
		say_phrase_for_toggles()	
	else:
		TTS_node.say_phrase(TTS_text + alternate_text)

func toggled(state: bool):
	toggle_state = state
	say_phrase_for_toggles()	

func _on_keyboard_input(event: InputEvent):
	if event is InputEventKey and !event.pressed:
		if button.has_focus():

			match event.as_text():
				"Enter":
					if is_Toggle:
						say_phrase_for_toggles()
					else: 		
						TTS_node.say_phrase("You selected " + TTS_text + alternate_text)	

				"Left":
					if is_Toggle:
						say_phrase_for_toggles()
					else: 		
						TTS_node.say_phrase(TTS_text + alternate_text)

				"Right":
					if is_Toggle:
						say_phrase_for_toggles()
					else: 		
						TTS_node.say_phrase(TTS_text + alternate_text)
				
				"Up":
					if is_Toggle:
						say_phrase_for_toggles()
					else: 		
						TTS_node.say_phrase(TTS_text + alternate_text)
				
				"Down":
					if is_Toggle:
						say_phrase_for_toggles()
					else: 		
						TTS_node.say_phrase(TTS_text + alternate_text)
				
	return

func say_phrase_for_toggles():
	if toggle_state:
		TTS_node.say_phrase(TTS_text + alternate_text + " on")
	else:
		TTS_node.say_phrase(TTS_text + alternate_text + " off")

func _on_button_up():
	if !is_Toggle:
		TTS_node.say_phrase("You selected " + TTS_text + alternate_text)