extends Node
class_name TTS_textfield_attachment
##UI attachment. Use to add TTS to LineEdit component

##Line edit component
@export var textfield: LineEdit

##TTS on this UI
@export var TTS_node: TTS

var TTS_text: String

func _ready():
	if TTS_node == null:
		printerr("TTS node not set")
		return

	TTS_text = textfield.text
	textfield.editable = false

	textfield.gui_input.connect(_on_keyboard_input)

func _on_keyboard_input(event: InputEvent):
	print(event)
	if event is InputEventKey and !event.pressed:
		if textfield.has_focus():

			match event.as_text():
				"Enter":
					if textfield.editable:
						textfield.editable = false
					else:
						textfield.editable = true						
					
				"Left":
					pass
				"Right":
					pass
				"Up":							
					pass
				"Down":						
					pass
				
	return