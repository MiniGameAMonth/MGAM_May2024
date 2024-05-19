class_name Interactable
extends StaticBody3D

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
	for shape in shapes:
		shape.disabled = false

func disable():
	for shape in shapes:
		shape.disabled = true
