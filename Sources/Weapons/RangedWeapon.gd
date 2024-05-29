class_name RangedWeapon
extends Weapon

@export var attackDistance : float = 10

var bullet;

func _ready():
	bullet = preload("res://GameObjects/Projectile.tscn")
	if bullet == null:
		push_error("Projectile is not set.")

func in_range(_target : Node3D):
	var distance = global_position.distance_to(_target.global_position)
	return distance <= attackDistance

func attack():
	if can_attack():
		shoot() #maybe shoot towards target
	if playSoundOnAttack:
		play_weapon_sound()

func shoot():
	var bulletInstance : Projectile = bullet.instantiate()
	get_tree().root.add_child(bulletInstance)
	bulletInstance.global_position = global_position
	bulletInstance.set_direction(global_transform.basis.z)
	bulletInstance.damage = weaponDamage

	if playSoundOnAttack:
		play_weapon_sound()
	cooldown.start(cooldownTime)
