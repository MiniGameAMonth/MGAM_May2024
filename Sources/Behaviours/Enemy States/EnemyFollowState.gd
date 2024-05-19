class_name EnemyFollowState
extends BehaviourState

var attackTarget : Node3D
var enemy_behaviour : EnemyBehaviour

func _init(_behaviour : Behaviour, _attackTarget : Node3D) -> void:
	super._init(_behaviour)
	attackTarget = _attackTarget
	enemy_behaviour = behaviour as EnemyBehaviour

func enter():
	enemy_behaviour.follower.follow(attackTarget)

func update(_delta : float):
	if enemy_behaviour.weapon.is_target_in_range(attackTarget):
		behaviour.change_state(EnemyAttackState.new(behaviour, attackTarget))
	else:
		var max_distance = enemy_behaviour.max_distance
		var position = enemy_behaviour.follower.characterBody.global_position
		if position.distance_to(attackTarget.global_position) > max_distance:
			behaviour.change_state(EnemyIdleState.new(behaviour))

func exit():
	enemy_behaviour.follower.follow(null)
