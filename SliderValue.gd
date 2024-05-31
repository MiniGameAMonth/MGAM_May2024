extends Label

@export var slider : Range
@export var suffix : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	slider.value_changed.connect(_on_slider_value_changed)
	text = str(slider.value) + suffix


func _on_slider_value_changed(value: float) -> void:
	text = str(value) + suffix
