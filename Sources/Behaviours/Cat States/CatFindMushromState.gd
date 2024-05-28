class_name CatFindMushroomState
extends BehaviourState

var graphics : AnimatedSprite3D
var interactable : Interactable
var cat : Follower
var lineOfSight : LineOfSight3D

var mushroom : WeakRef
var sniffing : bool = false

func _init(_behaviour : Behaviour, _mushroom : Node3D):
	super._init(_behaviour)
	mushroom = weakref(_mushroom)
	self.state_name = "CatFindMushroomState"

func enter():
	var owner = behaviour.behaviour_owner
	graphics = owner.get_node("Graphics") as AnimatedSprite3D
	cat = owner.get_node("Follower") as Follower
	lineOfSight = owner.get_node("LineOfSight3D") as LineOfSight3D

	graphics.play("walk")
	cat.follow(mushroom.get_ref())
	cat.resume()

func update(_delta : float):
	if mushroom.get_ref() != null:
		cat.follow(mushroom.get_ref())
		graphics.play("walk")
	else:
		behaviour.change_state(CatIdleState.new(behaviour))
	
	if cat.is_at_target():
		behaviour.change_state(CatSniffingState.new(behaviour, mushroom.get_ref()))
	else:
		if not lineOfSight.in_sight:
			behaviour.change_state(CatWaitForPlayerState.new(behaviour))

func exit():
	graphics.play("idle")

	
