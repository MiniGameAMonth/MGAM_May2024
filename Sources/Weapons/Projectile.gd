class_name Projectile
extends Node3D

@export var speed: float = 0
@export var life_time: float = 0
@export var target: Node3D = null

var damage: float = 0
var direction: Vector3 = Vector3.ZERO
var canvas;

func _ready():
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", _on_timeout)
	timer.start(life_time)

	check_for_target()

func set_direction(dir: Vector3) -> void:
	direction = dir
	check_for_target()

func set_speed(spd: float) -> void:
	speed = spd

func set_target(tgt: Node3D) -> void:
	target = tgt
	direction = (target.global_transform.origin - global_transform.origin).normalized()

func _physics_process(delta):
	global_transform.origin += direction * speed * delta


func _on_timeout():
	queue_free()

func _on_area_2d_body_entered(body:Node2D):    
	if body is EntityHitbox:
		body.character.take_damage(damage)
		queue_free()

func check_for_target():
	var area : Area2D = get_node("ProjectedNode/Area2D")
	var space_state = area.get_world_2d().direct_space_state
	var starting_point = Vector2(global_position.x, global_position.z) * Projected2DNode.PIXEL_PER_METER    
	var bullet_direction = Vector2(direction.x, direction.z) * 25 * Projected2DNode.PIXEL_PER_METER
	var offset = bullet_direction.rotated(-PI/2).normalized() * 5

	var query = PhysicsRayQueryParameters2D.create(starting_point + offset, starting_point + bullet_direction + offset)
	var query2 = PhysicsRayQueryParameters2D.create(starting_point - offset, starting_point + bullet_direction - offset)
	var result = space_state.intersect_ray(query)
	var result2 = space_state.intersect_ray(query2)
	
	if result:
		if result.collider is EntityHitbox:
			set_target(result.collider.character)
	if result2:
		if result2.collider is EntityHitbox:
			set_target(result2.collider.character)
