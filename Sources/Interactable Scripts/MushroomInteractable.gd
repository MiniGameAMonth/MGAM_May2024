class_name MushroomInteractable
extends Interactable

@export var mushroomData : MushroomData;

@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	if mushroomData.mushroomAnimations != null:
		sprite.sprite_frames = mushroomData.mushroomAnimations
		sprite.play("default")
	else:
		print("No animations found for mushroom : " + str(mushroomData.mushroomName))
	add_to_group(GroupNames.Mushrooms)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pick_up():
	remove_from_group(GroupNames.Mushrooms)
	print("picked up")
	#play animation pick up
	#play sound
	queue_free()
