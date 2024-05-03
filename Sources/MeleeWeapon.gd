class_name MeleeWeapon
extends Node

@export var meleeDamage : float
@export var player : Node3D

@onready var agent = $NavigationAgent3D
@onready var timer = $MeleeTimer

var isTimerOver : bool = true

func _process(delta):
    if isTargetInRange() and isTimerOver:
        dealDamage()

func isTargetInRange() -> bool:
    
    if agent.is_target_reached(player):
        return true
    else:
        return false

func dealDamage(): #deals damage to the player
    
    isTimerOver = false
    timer.start()

func _on_melee_timer_timeout():
    isTimerOver = true