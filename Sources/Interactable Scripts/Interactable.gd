class_name Interactable
extends Area3D

@export var interactableName : String;
@export var interactionPrompt : String;

var shapes : Array[CollisionShape3D]

func _ready():
	for child in get_children():
		if child is CollisionShape3D:
			shapes.append(child)

func interact(_who):
	#
	pass

func stop_interact(_who):
	#
	pass

func enable():
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

func disable():
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)