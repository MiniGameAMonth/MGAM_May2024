class_name Sight
extends Area3D

signal sighted(body : Node3D)
signal lost_sight(body : Node3D)

@export var require_line_of_sight : bool = false

var sighted_bodies : Array = []
var nearby_bodies : Array = []
var raycast : RayCast3D

func _ready():
	body_entered.connect(on_sighted)
	body_exited.connect(on_lost_sight)
	if require_line_of_sight:
		raycast = RayCast3D.new()
		raycast.enabled = false
		raycast.collision_mask = collision_mask
		add_child(raycast)

func _process(_delta):
	if not require_line_of_sight:
		return
	
	for body in nearby_bodies:
		if raycast_to(body):
			nearby_bodies.erase(body)
			sighted_bodies.append(body)
			emit_signal("sighted", body)

	for body in sighted_bodies:
		if not raycast_to(body):
			sighted_bodies.erase(body)
			nearby_bodies.append(body)
			emit_signal("lost_sight", body)

func on_sighted(body : Node3D) -> void:
	if require_line_of_sight:
		if not raycast_to(body):
			nearby_bodies.append(body)
			return

	sighted_bodies.append(body)
	emit_signal("sighted", body)

func on_lost_sight(body : Node3D) -> void:
	if body in sighted_bodies:
		sighted_bodies.erase(body)
		emit_signal("lost_sight", body)
	nearby_bodies.erase(body)

func raycast_to(body : Node3D) -> bool:
	raycast.target_position = to_local(body.global_transform.origin)
	raycast.force_raycast_update()
	return raycast.is_colliding() and raycast.get_collider() == body
