class_name EnemyAttackState
extends BehaviourState

var enemy_behaviour : EnemyBehaviour
var attackTarget : Node3D

func _init(_behaviour : EnemyBehaviour, _attackTarget : Node3D):
	self.behaviour = _behaviour
	self.enemy_behaviour = behaviour
	self.attackTarget = _attackTarget

func enter():
	enemy_behaviour = behaviour as EnemyBehaviour
	enemy_behaviour.animationPlayer.animation_finished.connect(animation_finished)

	enemy_behaviour.follower.follow(null)
	

	if not is_instance_valid(attackTarget):
		behaviour.change_state(EnemyIdleState.new(behaviour))
		return

func update(_delta):
	if enemy_behaviour.weapon.is_target_in_range(attackTarget):
		if enemy_behaviour.weapon.can_shoot():
			enemy_behaviour.animationPlayer.play("attack")
	else:
		behaviour.change_state(EnemyFollowState.new(behaviour, attackTarget))

func exit():
	enemy_behaviour.animationPlayer.animation_finished.disconnect(animation_finished)

func animation_finished(name : String):
	if name == "attack":
		behaviour.change_state(EnemyFollowState.new(behaviour, attackTarget))

	
