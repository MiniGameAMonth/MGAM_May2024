class_name CatInteractable
extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(_who):
	print("Pet by " + str(_who))
	#stop cat
	#play animation
	#play sound
	#continue
