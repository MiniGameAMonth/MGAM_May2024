extends MeleeWeapon

@export var attackDistance : float = 0 
@export var rangedDamage : float = 0 

@onready var ragedTimer = $RangedTimer

func _process(delta):
    if isTargetInRange() and isTimerOver:
        dealDamage()

func isTargetInRange():

    var distance = self.global_position.distance_to(player.global_position)

    if distance <= attackDistance:
        return true
    else:
        return false

func dealDamage(): #deals damage to the player
    
    isTimerOver = false
    ragedTimer.start()

func _on_ranged_timer_timeout():
    isTimerOver = true