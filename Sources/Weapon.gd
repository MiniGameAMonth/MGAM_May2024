class_name Weapon
extends Node3D

@export var attackDistance : float = 0 
@export var weaponDamage : float = 0
@export var cooldownTime : float = 0 

@onready var cooldown : Timer = $Cooldown

var isTimerOver : bool

func is_target_in_range(_target : Node3D):
    var distance = global_position.distance_to(_target.global_position)

    if distance <= attackDistance:
        return true
    else:
        return false

func try_deal_damage(_target : Node3D):
    if isTimerOver:
        var targetManager : CharacterManager = _target
        targetManager.take_damage(weaponDamage)
        cooldown.start(cooldownTime)

func _on_cooldown_timeout():
    isTimerOver = true