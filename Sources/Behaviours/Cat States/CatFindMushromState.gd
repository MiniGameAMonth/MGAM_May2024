class_name CatFindMushroomState
extends BehaviourState

var graphics : AnimatedSprite3D
var interactable : Interactable
var cat : Follower
var lineOfSight : LineOfSight3D

var mushroom : WeakRef
var sniffing : bool = false
var player : Player

func _init(_behaviour : Behaviour, _mushroom : Node3D):
	super._init(_behaviour)
	mushroom = weakref(_mushroom)
	self.state_name = "CatFindMushroomState"
	player = behaviour.get_tree().get_first_node_in_group(GroupNames.Players)

func enter():
	var owner = behaviour.behaviour_owner
	graphics = owner.get_node("Graphics") as AnimatedSprite3D
	cat = owner.get_node("Follower") as Follower
	lineOfSight = owner.get_node("LineOfSight3D") as LineOfSight3D

	player.ask_guide_star.connect(_on_ask_guide_star)

	graphics.play("walk")
	cat.follow(mushroom.get_ref())
	cat.resume()

func _on_ask_guide_star():
	behaviour.change_state(CatIdleState.new(behaviour))

func update(_delta : float):
	if mushroom.get_ref() != null:
		cat.follow(mushroom.get_ref())
		graphics.play("walk")
	else:
		behaviour.change_state(CatIdleState.new(behaviour))
	
	if cat.is_at_target():
		behaviour.change_state(CatSniffingState.new(behaviour, mushroom.get_ref()))
	else:
		if not lineOfSight.in_sight or behaviour.player_distance() > behaviour.maxDistanceFromPlayer:
			behaviour.change_state(CatWaitForPlayerState.new(behaviour, true))

func exit():
	graphics.play("idle")
	player.ask_guide_star.disconnect(_on_ask_guide_star)

	
