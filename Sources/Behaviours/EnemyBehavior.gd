class_name EnemyBehaviour
extends Behaviour

@export var follower : Follower
@export var weapon : Weapon
@export var sight : Sight
@export var max_distance : float = 20

var attackTarget : Node3D = null

func _ready():
	add_to_group(GroupNames.Enemies)

	if (follower == null):
		push_warning("Enemy : Follower not set.")
	if (weapon == null):
		push_warning("Enemy : Weapon not set.")

	if (sight == null):
		push_warning("Enemy : Sight not set.")
	else:
		sight.sighted.connect(attack_target)

	change_state(EnemyIdleState.new(self))
	

func _process(_delta):
	super._process(_delta)

func attack_target(target:Node3D):
	if target.name != "Player":
		return
	attackTarget = target
	change_state(EnemyFollowState.new(self, target))

func die():
	remove_from_group(GroupNames.Enemies)