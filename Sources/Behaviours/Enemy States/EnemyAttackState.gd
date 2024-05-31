class_name EnemyAttackState
extends BehaviourState

var enemy_behaviour : EnemyBehaviour
var attackTarget : Node3D

func _init(_behaviour : EnemyBehaviour, _attackTarget : Node3D):
	self.behaviour = _behaviour
	self.enemy_behaviour = behaviour
	self.attackTarget = _attackTarget
	state_name = "EnemyAttackState"

func enter():
	enemy_behaviour = behaviour as EnemyBehaviour
	enemy_behaviour.animationPlayer.animation_finished.connect(animation_finished)

	enemy_behaviour.follower.follow(null)
	enemy_behaviour.follower.stop()
	

	if not is_instance_valid(attackTarget):
		behaviour.change_state(EnemyIdleState.new(behaviour))
		return

func update(_delta):
	enemy_behaviour.animationPlayer.play("attack")

func exit():
	enemy_behaviour.animationPlayer.animation_finished.disconnect(animation_finished)
	enemy_behaviour.follower.resume()

func animation_finished(name : String):
	if name == "attack":
		behaviour.change_state(EnemyFollowState.new(behaviour, attackTarget))

	
