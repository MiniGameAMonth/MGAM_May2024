class_name InteractionArea3D
extends Area3D

signal on_interaction(object : Interactable)
signal on_interaction_end(object : Interactable)

var interactables : Array[Interactable] = []
var enabled : bool = true

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(body:Area3D):
	if body is Interactable and enabled:
		interactables.append(body)
		if enabled:
			on_interaction.emit(body)


func _on_area_exited(body:Area3D):
	if body is Interactable:
		interactables.erase(body)
		if enabled:
			on_interaction_end.emit(body)
			if interactables.size() > 0:
				on_interaction.emit(interactables[-1])

func disable():
	if interactables.size() > 0 and enabled:
		on_interaction_end.emit(interactables[-1])
	enabled = false

func enable():
	if interactables.size() > 0 and not enabled:
		on_interaction.emit(interactables[-1])
	enabled = true

