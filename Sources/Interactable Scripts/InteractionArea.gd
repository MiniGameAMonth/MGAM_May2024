class_name InteractionArea
extends Area3D

signal on_interaction(object : Interactable)
signal on_interaction_end(object : Interactable)

var interactables : Array[Interactable] = []

func _on_body_entered(body:Node3D):
	if body is Interactable:
		interactables.append(body)
		on_interaction.emit(body)


func _on_body_exited(body:Node3D):
	if body is Interactable:
		interactables.erase(body)
		on_interaction_end.emit(body)
		if interactables.size() > 0:
			on_interaction.emit(interactables[-1])
