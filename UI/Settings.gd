extends Control

@export var mainMenuScene : String;

# Called when the node enters the scene tree for the first time.
func _ready():
	print(mainMenuScene)
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Main.change_level(mainMenuScene)
