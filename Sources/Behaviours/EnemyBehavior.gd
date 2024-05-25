class_name EnemyBehaviour
extends Behaviour

@export var follower : Follower
@export var weapon : Weapon
@export var animationPlayer : AnimationPlayer
@export var graphics : AnimatedSprite3D
@onready var sight : Sight = $Sight
@export var max_distance : float = 50
@export var sightedSound : PlaySound3D
@onready var targetLineOfSight : LineOfSight3D = $LineOfSight3D

var attackTarget : Node3D = null

func _ready():
	get_parent().add_to_group(GroupNames.Enemies)

	if (follower == null):
		push_warning("Enemy : Follower not set.")
	if (weapon == null):
		push_warning("Enemy : Weapon not set.")

	if (sight == null):
		push_warning("Enemy : Sight not set.")
	else:
		sight.sighted.connect(attack_target)

	targetLineOfSight.set_target_offset(Vector3(0, 1, 0))

	change_state(EnemyIdleState.new(self))
	

func _process(_delta):
	super._process(_delta)

func attack_target(target:Node3D):
	if target.name != "Player":
		return
	attackTarget = target
	targetLineOfSight.target = target

func play_attack():
	weapon.try_deal_damage(attackTarget)

func die():
	remove_from_group(GroupNames.Enemies)