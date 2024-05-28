class_name Weapon
extends Node3D

@export var weaponDamage : int = 0
@export var cooldownTime : float = 0 
@export var playSoundOnAttack : bool = true

@onready var cooldown : Timer = $Cooldown
@onready var weaponSound : AudioStreamPlayer3D = $AudioStreamPlayer3D

func in_range(_target : Node3D):
	return false

func try_attack():
	if can_attack():
		attack()
		cooldown.start(cooldownTime)

func can_attack():
	return cooldown.time_left <= 0

func play_weapon_sound():
	weaponSound.play()

func attack():
	pass

func _on_cooldown_timeout():
	pass
