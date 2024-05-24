extends Node
class_name TTS_textfield_attachment
##UI attachment. Use to add TTS to LineEdit component

##Line edit component
@export var textfield: LineEdit

##Description of the textfield (e.g. what do you need to type in here)
@export var description_text: String

var TTS_text: String

func _ready():
	if TTS == null:
		printerr("TTS node not set")
		return

	TTS_text = textfield.text
	textfield.editable = false

	textfield.gui_input.connect(_on_keyboard_input)
	textfield.mouse_entered.connect(_on_mouse_entered)
	textfield.text_submitted.connect(_on_text_submision)

func _on_keyboard_input(event: InputEvent):
	if event is InputEventKey and !event.pressed:
		if textfield.has_focus():
			match event.as_text():					
				"Up":							
					TTS.say_phrase(description_text + ":" + TTS_text)	
				"Down":						
					TTS.say_phrase(description_text + ":" + TTS_text)		

func _on_mouse_entered():
	TTS.say_phrase(description_text + ":" + TTS_text)

func _on_text_submision(text: String):
	TTS_text = text
	TTS.say_phrase("You changed the text to: " + TTS_text)