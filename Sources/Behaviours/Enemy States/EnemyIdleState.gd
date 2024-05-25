class_name EnemyIdleState
extends BehaviourState

var enemy_behaviour: EnemyBehaviour

func enter():
    enemy_behaviour = behaviour as EnemyBehaviour
    enemy_behaviour.graphics.play("idle")
    enemy_behaviour.sight.sighted.connect(sighted)

func update(_delta):
    for body in enemy_behaviour.sight.sighted_bodies:
        if body.name == "Player":
            enemy_behaviour.change_state(EnemyFollowState.new(behaviour, body))

func sighted(target):
    if target.name == "Player":
        enemy_behaviour.sightedSound.play()
        enemy_behaviour.change_state(EnemyFollowState.new(behaviour, target))

func exit():
    enemy_behaviour.sight.sighted.disconnect(sighted)