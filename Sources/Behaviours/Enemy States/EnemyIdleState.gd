class_name EnemyIdleState
extends BehaviourState

var enemy_behaviour: EnemyBehaviour

func enter():
	enemy_behaviour = behaviour as EnemyBehaviour
	enemy_behaviour.graphics.play("idle")
	enemy_behaviour.sight.sighted.connect(sighted)
	state_name = "Enemy Idle"
	var randomNumber = (float(randi() % 1000) / 1000) * 5
	enemy_behaviour.get_tree().create_timer(randomNumber).timeout.connect(_start_idle)
	#enemy_behaviour.idleSound.play()

func _start_idle():
	enemy_behaviour.idleSound.play()

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
	enemy_behaviour.idleSound.stop()
