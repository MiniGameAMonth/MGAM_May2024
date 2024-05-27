class_name CatFindMushroomState
extends BehaviourState

var graphics : AnimatedSprite3D
var interactable : Interactable
var cat : Follower
var lineOfSight : LineOfSight3D

var mushroom : WeakRef

func _init(_behaviour : Behaviour, _mushroom : Node3D):
	super._init(_behaviour)
	mushroom = weakref(_mushroom)
	self.state_name = "CatFindMushroomState"

func enter():
	var owner = behaviour.behaviour_owner
	graphics = owner.get_node("Graphics") as AnimatedSprite3D
	interactable = owner.get_node("Interactable") as Interactable
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
	
	#near mushroom
	if cat.is_at_target():
		graphics.play("sniff")
		interactable.disable()
	else:
		if not lineOfSight.in_sight:
			behaviour.change_state(CatWaitForPlayerState.new(behaviour))

func exit():
	graphics.play("idle")
	interactable.enable()    

	
