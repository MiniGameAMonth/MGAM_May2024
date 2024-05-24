extends Node
class_name TTS_slider_attachment
##UI attachment. Use to add TTS to a Slider UI element

##Slider that needs to be read out by the TTS
@export var slider: Slider

##Name of the option that is being read out
@export var option_name: String

##The unit of the value (degrees, potatoes, ...).
##Leave empty if you don't want to specify a unit
@export var unit_value: String

var TTS_text: String
var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)	

	option_name = option_name + "..."

	slider.mouse_entered.connect(_on_mouse_entered)	
	slider.gui_input.connect(_on_keyboard_input)
	slider.value_changed.connect(_on_value_change)
	timer.timeout.connect(say_phrase)

func _on_mouse_entered():
	say_phrase()	

func _on_keyboard_input(event: InputEvent):
	if event is InputEventKey and !event.pressed:
		if slider.has_focus():

			match event.as_text():				
				"Up":							
					say_phrase()
				
				"Down":						
					say_phrase()
				
	return

func _on_value_change(_value: float):
	timer.start(0.1)

func say_phrase():
	timer.stop()
	TTS.say_phrase(option_name + str(slider.value) + unit_value)