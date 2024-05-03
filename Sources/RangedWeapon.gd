class_name MeleeWeapon
extends Node3D

@export var attackDistance : float = 0 
@export var rangedDamage : float = 0 

@onready var rangedTimer : Timer = $RangedTimer

var isTimerOver : bool

func is_target_in_range(_target : Node3D):
    var distance = global_position.distance_to(_target.global_position)

    if distance <= attackDistance:
        return true
    else:
        return false

func try_deal_damage(): #deals damage to the player
    isTimerOver = not (rangedTimer.time_left > 0)
    rangedTimer.start()

func _on_ranged_timer_timeout():
    isTimerOver = true