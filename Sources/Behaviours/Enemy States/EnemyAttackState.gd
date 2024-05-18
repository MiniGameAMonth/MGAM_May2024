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

func update(_delta):
	if attackTarget != null:
		if enemy_behaviour.weapon.is_target_in_range(attackTarget):
			enemy_behaviour.follower.follow(null)
			enemy_behaviour.weapon.try_deal_damage(attackTarget)
	# TODO: delay until animation is finished
	behaviour.change_state(EnemyFollowState.new(behaviour, attackTarget))

	