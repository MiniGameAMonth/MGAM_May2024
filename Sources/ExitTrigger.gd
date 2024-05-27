extends Area3D

@export_file var next_level : String
var current_level : Node3D


func _ready():
	current_level = get_tree().root.get_node("MainRoot/Level/Level")


func _on_body_entered(body):
	if body.name == "Player":
		var mushrooms_left = current_level.get_node("Mushrooms").get_child_count()

		if mushrooms_left == 0:
			Main.load_level(next_level)
		else:
			var get_mushrooms_message = body.get_node("CanvasLayer/GetMushroomsMessage")
			get_mushrooms_message.text = "You have %s mushrooms left to collect\nbefore you can exit" % mushrooms_left
			get_mushrooms_message.show()


func _on_body_exited(body):	
	if body.name == "Player":
		body.get_node("CanvasLayer/GetMushroomsMessage").hide()
