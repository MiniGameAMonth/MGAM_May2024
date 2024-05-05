class_name Weapon
extends Node3D

@export var attackDistance : float = 0 
@export var weaponDamage : float = 0
@export var cooldownTime : float = 0 
@export var bullet : PackedScene
@export var player : Node3D

@onready var cooldown : Timer = $Cooldown

var isTimerOver : bool = true

func _ready():
	isTimerOver = true
	if bullet == null:
		print("Bullet is not set")
		return

func is_target_in_range(_target : Node3D):
	var distance = global_position.distance_to(_target.global_position)

	if distance <= attackDistance:
		return true
	else:
		return false

func try_deal_damage(_target : Node3D):
	if isTimerOver:
		var target : Character = _target.get_node("Character")
		target.take_damage(weaponDamage)
		cooldown.start(cooldownTime)

func shoot(): 	
	if isTimerOver:
		var playerDirection : Vector3 = -player.global_transform.basis.z

		var bulletInstance : Projectile = load("GameObjects/Bullet.tscn").instantiate()
		get_tree().root.add_child(bulletInstance)

		bulletInstance.global_position = global_position
		bulletInstance.set_direction(playerDirection)
		bulletInstance.damage = weaponDamage     
	
func _on_cooldown_timeout():
	isTimerOver = true
