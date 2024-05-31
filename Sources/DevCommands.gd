extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.keycode == 49 and event.pressed and event.ctrl_pressed and event.alt_pressed:
			Main.change_level("res://Levels/Level1.tscn")
		if event.keycode == 50 and event.pressed and event.ctrl_pressed and event.alt_pressed:
			print("skip to 2")
			Main.change_level("res://Levels/Level2.tscn")
		if event.keycode == 51 and event.pressed and event.ctrl_pressed and event.alt_pressed:
			Main.change_level("res://Levels/Level3.tscn")
