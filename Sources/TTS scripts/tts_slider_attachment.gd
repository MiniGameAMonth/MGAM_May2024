extends Node
class_name TTS_slider_attachment
##UI attachment. Use to add TTS to a Slider UI element

##Slider that needs to be read out by the TTS
@export var slider: Slider

##Name of the option that is being read out
@export var option_name: String

##TTS node on this UI
@export var TTS_node: TTS

##The unit of the value (degrees, potatoes, ...).
##Leave empty if you don't want to specify a unit
@export var unit_value: String

var TTS_text: String

func _ready():
	if TTS_node == null:
		printerr("TTS node not set")
		return

	option_name = option_name + "..."

	slider.mouse_entered.connect(_on_mouse_entered)
	slider.gui_input.connect(_on_keyboard_input)
	slider.value_changed.connect(_on_value_change)

func _on_mouse_entered():
	TTS_node.say_phrase(option_name + str(slider.value) + unit_value)

func _on_keyboard_input(event: InputEvent):
	if event is InputEventKey and !event.pressed:
		if slider.has_focus():

			match event.as_text():				
				"Up":							
					TTS_node.say_phrase(option_name + str(slider.value) + unit_value)
				
				"Down":						
					TTS_node.say_phrase(option_name + str(slider.value) + unit_value)
				
	return

func _on_value_change(value: float):
	TTS_node.say_phrase(option_name + str(value) + unit_value)
