class_name InteractionArea
extends Area3D

signal on_interaction(object : Interactable)
signal on_interaction_end(object : Interactable)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body:Node3D):
	if body is Interactable:
		emit_signal("on_interaction", body)


func _on_body_exited(body:Node3D):
	if body is Interactable:
		emit_signal("on_interaction_end", body)
