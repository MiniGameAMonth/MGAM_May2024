class_name MushroomInteractable
extends Interactable

@export var mushroomData : MushroomData;
@export var pickupSound : AudioStreamPlayer3D;

@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_mushroom(mushroomData)
	add_to_group(GroupNames.Mushrooms)

func setup_mushroom(data : MushroomData):
	interactableName = data.mushroomName
	if data.mushroomAnimations != null:
		sprite.sprite_frames = data.mushroomAnimations
		sprite.play("default")
	else:
		push_warning("No animations found for mushroom : " + str(data.mushroomName))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(_who):
	remove_from_group(GroupNames.Mushrooms)
	print("picked up")
	#play animation pick up
	#play sound
	GameSfx.play_sound(pickupSound)
	queue_free()
