class_name MushroomInteractable
extends Interactable

@export var mushroomData : MushroomData;

@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_mushroom(mushroomData)
	add_to_group(GroupNames.Mushrooms)

func setup_mushroom(data : MushroomData):
	pickUpName = data.mushroomName
	if data.mushroomAnimations != null:
		sprite.sprite_frames = data.mushroomAnimations
		sprite.play("default")
	else:
		print("No animations found for mushroom : " + str(data.mushroomName))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func pick_up(_picker):
	remove_from_group(GroupNames.Mushrooms)
	print("picked up")
	#play animation pick up
	#play sound
	queue_free()
