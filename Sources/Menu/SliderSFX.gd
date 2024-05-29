class_name SliderSFX
extends Node

@export var focused_sfx : AudioStreamPlayer
@export var pressed_sfx : AudioStreamPlayer
@export var mouse_over_sfx : AudioStreamPlayer

var playing : bool = false

func _ready():
	var parent : Slider = get_parent()
	parent.value_changed.connect(Callable(func lambda(_x): _on_pressed()))
	parent.focus_entered.connect(_on_focus_entered)
	parent.mouse_entered.connect(_on_mouse_entered)

func _on_pressed():
	if pressed_sfx and not pressed_sfx.playing:
		pressed_sfx.play()

func _on_focus_entered():
	if focused_sfx and not focused_sfx.playing:
		focused_sfx.play()

func _on_mouse_entered():
	if mouse_over_sfx and not mouse_over_sfx.playing:
		mouse_over_sfx.play()
