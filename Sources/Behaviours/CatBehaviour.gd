class_name CatBehaviour
extends Behaviour

enum State { IDLE, WALK_TO_MUSHROOM, WAIT_FOR_PLAYER, WALK_TO_EXIT, NEAR_MUSHROOM, NEAR_EXIT }

var lastState : State = State.IDLE
var state : State = State.IDLE
var targetMushroom : Node3D;

@export var maxDistanceFromPlayer : float = 20

@export var cat : Follower;

@export var graphics : AnimatedSprite3D
@export var interactionArea : Interactable

@export var lineOfSight : LineOfSight3D

@onready var waitForPlayerSound : PlaySound3D = $WaitForPlayerSound
@onready var enemySight : Sight = $EnemySight
@onready var enemyBackpackSight : Sight = $EnemyBackpackSight
@onready var magicalCatSound : PlaySound3D = $MagicalCatSound
@onready var sniffingSound : PlaySound3D = $SniffingSound
@onready var backpackSound : PlaySound3D = $BackpackSound
@onready var scaredCatSound : PlaySound3D = $ScaredCatSound

var player : Node3D = null

func _ready():
	add_to_group(GroupNames.Cat)
	lineOfSight.set_origin_offset(Vector3(0, 2, -1.5))
	lineOfSight.set_target_offset(Vector3(0, 1, 0))

	enemySight.sighted.connect(check_enemies_in_sight)


func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group(GroupNames.Player)
		if player == null:
			return
		else:
			lineOfSight.set_target(player)
			change_state(CatIdleState.new(self))

	super._process(_delta)

func player_distance():
	return player.global_position.distance_to(self.global_position)

func check_enemies_in_sight(body : Node3D):
	if current_state is CatGoInBackpackState:
		return
	
	if body.is_in_group(GroupNames.Enemies):
		change_state(CatGoInBackpackState.new(self))


