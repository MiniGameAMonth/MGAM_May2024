extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_in_backpack():
	var cat_behaviour = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("Cat Behaviour")
	cat_behaviour.change_state(CatGoInBackpackState.new(cat_behaviour))
