class_name Projectile
extends Node3D

@export var speed: float = 0
@export var life_time: float = 0
@export var target: Node3D = null
@export var enable_aim: bool = true
var target_ref : WeakRef

var damage: float = 0
var direction: Vector3 = Vector3.ZERO
var offset_pixels
var space_state

func _ready():
	var collision_shape = get_node("%CollisionShape2D")
	var circle_shape = collision_shape.shape as CircleShape2D
	offset_pixels = circle_shape.radius

	var timer : Timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", _on_timeout)
	timer.start(life_time)

	var area : Area2D = get_node("ProjectedNode/Area2D")
	space_state = area.get_world_2d().direct_space_state

	check_for_target()

func set_direction(dir: Vector3) -> void:
	direction = dir
	target = null
	if enable_aim:
		check_for_target()

func set_speed(spd: float) -> void:
	speed = spd

func set_target(tgt: Node3D) -> void:
	target = tgt
	target_ref = weakref(tgt)
	direction = (target.global_transform.origin - global_transform.origin).normalized()

func _physics_process(delta):
	if is_instance_valid(target) and enable_aim:
		direction = (target.global_transform.origin - global_transform.origin).normalized()
	global_transform.origin += direction * speed * delta

func _on_timeout():
	queue_free()

func _on_area_2d_body_entered(body:Node2D):    
	if body is EntityHitbox2D:
		body.character.take_damage(damage)
		queue_free()

func check_for_target():
	var starting_point = Vector2(global_position.x, global_position.z) * Projected2DNode.PIXEL_PER_METER    
	var bullet_direction = Vector2(direction.x, direction.z) * 50 * Projected2DNode.PIXEL_PER_METER
	var offset = bullet_direction.rotated(-PI/2).normalized() * offset_pixels

	var query = PhysicsRayQueryParameters2D.create(starting_point + offset, starting_point + bullet_direction + offset)
	var query2 = PhysicsRayQueryParameters2D.create(starting_point - offset, starting_point + bullet_direction - offset)
	check_query(query)
	check_query(query2)

func check_query(query):
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider is EntityHitbox2D:
			set_target(result.collider.character)
