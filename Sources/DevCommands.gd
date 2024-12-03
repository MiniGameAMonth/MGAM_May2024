extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("skip_to_1"):
		Main.change_level("res://Levels/Level1.tscn")

	if Input.is_action_just_pressed("skip_to_2"):
		Main.change_level("res://Levels/Level2.tscn")
	
	if Input.is_action_just_pressed("skip_to_3"):
		Main.change_level("res://Levels/Level3.tscn")
