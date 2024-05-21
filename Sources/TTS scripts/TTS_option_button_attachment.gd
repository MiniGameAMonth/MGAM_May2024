extends Node
class_name TTS_option_button_attachment
##UI attachment. Use to add TTS to an OptionButton UI element

##OptionButton(type) that needs to be read out by the TTS
@export var option_button: OptionButton

##Name of the option that is being read out
@export var option_name: String

##TTS node on this UI
@export var TTS_node: TTS

var TTS_text: String

func _ready():
	if TTS_node == null:
		printerr("TTS node not set")
		return

	option_name = option_name + "..."

	option_button.mouse_entered.connect(_on_mouse_entered)	
	option_button.item_focused.connect(_on_item_focused)
	option_button.item_selected.connect(_on_item_changed)
	option_button.gui_input.connect(_on_keyboard_input)

func _on_mouse_entered():
	TTS_text = option_button.get_item_text(option_button.selected)
	TTS_node.say_phrase(option_name + TTS_text)

func _on_keyboard_input(event: InputEvent):
	if event is InputEventKey and !event.pressed:
		if option_button.has_focus():

			match event.as_text():
				"Left":
					TTS_text = option_button.get_item_text(option_button.selected)
					TTS_node.say_phrase(option_name + TTS_text)

				"Right":
					TTS_text = option_button.get_item_text(option_button.selected)
					TTS_node.say_phrase(option_name + TTS_text)
				
				"Up":							
					TTS_text = option_button.get_item_text(option_button.selected)
					TTS_node.say_phrase(option_name + TTS_text)
				
				"Down":						
					TTS_text = option_button.get_item_text(option_button.selected)
					TTS_node.say_phrase(option_name + TTS_text)	

func _on_item_focused(index: int):
	TTS_text = option_button.get_item_text(index)
	TTS_node.say_phrase(option_name + TTS_text)

func _on_item_changed(index: int):
	TTS_text = option_button.get_item_text(index)
	TTS_node.say_phrase("You selected " + TTS_text)