class_name MeleeWeapon
extends Weapon

@export var attackDistance : float = 3
@export var attackShape : ShapeCast3D

var bullet;

func _ready():
	bullet = preload("res://GameObjects/Projectile.tscn")
	if bullet == null:
		push_error("Projectile is not set.")

func in_range(_target : Node3D):
	var distance = global_position.distance_to(_target.global_position)
	return distance <= attackDistance

func attack():
	# box cast
	attackShape.force_shapecast_update()
	for index in range(attackShape.get_collision_count()):
		var hit = attackShape.get_collider(index)
		if hit.has_node("Character"):
			var character = hit.get_node("Character")
			character.take_damage(weaponDamage)

	if playSoundOnAttack:
		play_weapon_sound()
