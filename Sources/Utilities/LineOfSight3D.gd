class_name LineOfSight3D
extends RayCast3D

signal on_sight_entered(body : Node3D)
signal on_sight_exited(body : Node3D)

@export var target : Node3D = null
var in_sight : bool = false
var origin_offset : Vector3 = Vector3(0, 0, 0)
var target_offset : Vector3 = Vector3(0, 0, 0)


func _process(_delta):
	if target != null:
		target_position = to_local(target.global_position) + target_offset
		force_raycast_update()

		if is_colliding():
			if get_collider() == target:
				if not in_sight:
					in_sight = true
					emit_signal("on_sight_entered", get_collider())
			else:
				if in_sight:
					in_sight = false
					emit_signal("on_sight_exited", get_collider())
		else:
			if in_sight:
				in_sight = false
				emit_signal("on_sight_exited", get_collider())

func set_origin(origin : Node3D) -> void:
	global_transform.origin = origin.global_transform.origin

func set_origin_offset(offset : Vector3) -> void:
	position = offset

func set_target(_target : Node3D) -> void:
	target = _target

func set_target_offset(offset : Vector3) -> void:
	target_offset = offset

