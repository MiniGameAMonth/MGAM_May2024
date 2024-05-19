class_name EnemyIdleState
extends BehaviourState

var enemy_behaviour: EnemyBehaviour

func enter():
    enemy_behaviour = behaviour as EnemyBehaviour
    enemy_behaviour.graphics.play("idle")
    pass

func update(_delta):
    # Check if the player is in range
    pass