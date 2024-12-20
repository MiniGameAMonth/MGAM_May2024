class_name DirectionalAnimatedSprite3D
extends AnimatedSprite3D

@export var back_sprite_frames : SpriteFrames
@export var front_sprite_frames : SpriteFrames
@export var side_sprite_frames : SpriteFrames

var observer : Node3D

func _ready():
	var observers = get_tree().get_nodes_in_group("Player")
	if observers.size() == 0:
		observer = null

func _process(_delta):
	if observer == null:
		var observers = get_tree().get_nodes_in_group("Player")
		if observers.size() > 0:
			observer = observers[0]
		else:
			return

	var observer_direction_3d = global_transform.origin - observer.global_transform.origin
	var observer_direction_2d = Vector2(observer_direction_3d.x, observer_direction_3d.z).normalized()
	var parent_direction = get_parent().global_transform.basis[0]
	var sprite_direction = Vector2(parent_direction.x, parent_direction.z).normalized()

	var angle = observer_direction_2d.angle_to(sprite_direction)
	flip_h = false

	if angle > -3*PI/4 and angle < -PI/4:
		sprite_frames = front_sprite_frames
		basis = Basis().rotated(Vector3(0, 1, 0), 0)
	elif angle > -PI/4 and angle < PI/4:
		sprite_frames = side_sprite_frames
		basis = Basis().rotated(Vector3(0, 1, 0), -PI/2)
	elif angle > PI/4 and angle < 3*PI/4:
		sprite_frames = back_sprite_frames
		basis = Basis().rotated(Vector3(0, 1, 0), 0)
	else:
		sprite_frames = side_sprite_frames
		basis = Basis().rotated(Vector3(0, 1, 0), -PI/2)

	play(animation)
