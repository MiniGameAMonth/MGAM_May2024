class_name VolumeSlider
extends Node

@export var bus : String = "Master"
var slider_min_value : float
var slider_max_value : float
var min_db : float = -40
var max_db : float = 0

var _audio_bus : int

# Called when the node enters the scene tree for the first time.
func _ready():
	var slider : Slider = get_parent()
	slider_min_value = slider.min_value
	slider_max_value = slider.max_value
	slider.value_changed.connect(_on_slider_value_changed)

	_audio_bus = AudioServer.get_bus_index(bus)


func _on_slider_value_changed(value: float) -> void:
	if _audio_bus != -1:
		var t = (value - slider_min_value) / slider_max_value
		var db = lerp(min_db, max_db, t)
		AudioServer.set_bus_volume_db(_audio_bus, db)
	else:
		push_error("Bus not found: " + bus)
