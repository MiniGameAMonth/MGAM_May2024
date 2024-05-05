class_name Projectile
extends Node3D

@export var speed: float = 0
@export var life_time: float = 0
@export var target: Node3D = null

var damage: float = 0
var direction: Vector3 = Vector3.ZERO
var space_state

func _ready():
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.start(life_time)

	timer.connect("timeout", _on_timeout)
	var area : Area2D = get_node("ProjectedNode/Area2D")
	
	#var space_state_id = PhysicsServer2D.area_get_space(area)
	space_state = area.get_world_2d().direct_space_state

func set_direction(dir: Vector3) -> void:
	direction = dir

func set_speed(spd: float) -> void:
	speed = spd

func set_target(tgt: Node3D) -> void:
	target = tgt

func _physics_process(delta):
	if target:
		direction = (target.global_transform.origin - global_transform.origin).normalized()
		global_transform.origin += direction * speed * delta
	
	global_transform.origin += direction * speed * delta

	var starting_point : Vector2 = Vector2(global_position.x, global_position.z)    
	var bullet_direction : Vector2 = Vector2(direction.x, direction.z)

	var query = PhysicsRayQueryParameters2D.create(starting_point, bullet_direction * 1000 + starting_point)
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	print(result)
	print(starting_point, bullet_direction * 1000 + starting_point)

	
	if result:
		if result.collider is EntityHitbox:
			target = result.collider.character

func _on_timeout():
	queue_free()

func _on_area_2d_body_entered(body:Node2D):    
	if body is EntityHitbox:
		body.character.take_damage(damage)
		queue_free()
