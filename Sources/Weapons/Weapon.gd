class_name Weapon
extends Node3D


@export var attackDistance : float = 0 
@export var weaponDamage : int = 0
@export var cooldownTime : float = 0 

@export var playSoundOnDamage : bool = true

@onready var cooldown : Timer = $Cooldown
@onready var weaponSound : AudioStreamPlayer3D = $AudioStreamPlayer3D

var bullet;

func _ready():
	bullet = preload("res://GameObjects/Projectile.tscn")
	if bullet == null:
		push_error("Projectile is not set.")

func is_target_in_range(_target : Node3D):
	var distance = global_position.distance_to(_target.global_position)
	return distance <= attackDistance

func try_deal_damage(_target : Node3D):
	if can_shoot():
		var target : Character = _target.get_node("Character")
		if target != null:
			if is_target_in_range(target):
				deal_damage(target)
				cooldown.start(cooldownTime)

func can_shoot():
	return cooldown.time_left <= 0

func play_weapon_sound():
	weaponSound.play()

func deal_damage(target : Character):
	target.take_damage(weaponDamage)
	if playSoundOnDamage:
		play_weapon_sound()

func shoot():
	if can_shoot():
		var bulletInstance : Projectile = bullet.instantiate()
		get_tree().root.add_child(bulletInstance)
		bulletInstance.global_position = global_position
		bulletInstance.set_direction(global_transform.basis.z)
		bulletInstance.damage = weaponDamage

		if playSoundOnDamage:
			play_weapon_sound()
		cooldown.start(cooldownTime)
	
func _on_cooldown_timeout():
	pass
