class_name EnemyIdleState
extends BehaviourState

var enemy_behaviour: EnemyBehaviour

func enter():
    enemy_behaviour = behaviour as EnemyBehaviour
    enemy_behaviour.graphics.play("idle")
    enemy_behaviour.sight.sighted.connect(sighted)

func update(_delta):
    # Check if the player is in range
    pass

func sighted(target):
    # Change state to chase
    if target.name == "Player":
        enemy_behaviour.sightedSound.play()
        enemy_behaviour.change_state(EnemyFollowState.new(behaviour, target))

func exit():
    enemy_behaviour.sight.sighted.disconnect(sighted)