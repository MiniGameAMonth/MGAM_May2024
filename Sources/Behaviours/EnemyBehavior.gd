class_name EnemyBehaviour
extends Node3D

@export var follower : Follower
@export var weapon : Weapon
@export var sight : Sight
@export var max_distance : float = 20

enum EnemyStates { IDLE, WANDER, FOLLOW, ATTACK, DEAD }
var state : EnemyStates = EnemyStates.IDLE

var attackTarget : Node3D = null

func _ready():
	if (follower == null):
		push_warning("Enemy : Follower not set.")
	if (weapon == null):
		push_warning("Enemy : Weapon not set.")

	if (sight == null):
		push_warning("Enemy : Sight not set.")
	else:
		sight.sighted.connect(attack_target)
	

func _process(_delta):
	if state == EnemyStates.IDLE:
		#do nothing
		pass
	elif state == EnemyStates.WANDER:
		#do nothing
		pass
	elif state == EnemyStates.FOLLOW:
		if attackTarget != null:
			follower.follow(attackTarget)
		if weapon.is_target_in_range(attackTarget):
			state = EnemyStates.ATTACK
		if global_position.distance_to(attackTarget.global_position) > max_distance:
			state = EnemyStates.IDLE
	elif state == EnemyStates.ATTACK:
		
		if attackTarget != null:
			if weapon.is_target_in_range(attackTarget):
				follower.follow(null)
				weapon.try_deal_damage(attackTarget)
			else:
				state = EnemyStates.FOLLOW
		else:
			state = EnemyStates.IDLE
	elif state == EnemyStates.DEAD:
		pass
	

func attack_target(target:Node3D):
	if target.name != "Player":
		return
	attackTarget = target
	state = EnemyStates.FOLLOW

