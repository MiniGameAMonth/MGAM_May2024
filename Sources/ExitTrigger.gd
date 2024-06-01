extends Area3D

@export_file var next_level : String
var current_level : Node3D
var mushroom_collected : bool = false

func _ready():
	current_level = get_tree().root.get_node("MainRoot/Level").get_child(0)
	GlobalEvents.collected_all_mushrooms.connect(on_mushroom_collected)

func _on_body_entered(body):
	if body.name == "Player":
		
		if mushroom_collected:
			Main.load_level(next_level)
		else:
			var get_mushrooms_message = body.get_node("CanvasLayer/GetMushroomsMessage")
			get_mushrooms_message.text = "You don't have all the mushrooms yet!"
			get_mushrooms_message.show()


func _on_body_exited(body):	
	if body.name == "Player":
		body.get_node("CanvasLayer/GetMushroomsMessage").hide()

func on_mushroom_collected():
	mushroom_collected = true