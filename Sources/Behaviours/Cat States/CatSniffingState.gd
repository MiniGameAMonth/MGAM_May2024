class_name CatSniffingState
extends BehaviourState

var mushroom : WeakRef
var cat_behaviour : CatBehaviour

func _init(_behaviour : Behaviour, _mushroom : Node3D):
	self.behaviour = _behaviour
	self.mushroom = weakref(_mushroom)
	self.cat_behaviour = behaviour as CatBehaviour

func enter():
	cat_behaviour.graphics.play("sniff")
	cat_behaviour.interactionArea.disable()
	cat_behaviour.cat.stop()

	cat_behaviour.magicalCatSound.play()
	cat_behaviour.sniffingSound.play()

func update(_delta: float):
	if mushroom.get_ref() == null:
		behaviour.change_state(CatIdleState.new(behaviour))

func exit():
	cat_behaviour.interactionArea.enable()
	cat_behaviour.magicalCatSound.stop()
	cat_behaviour.sniffingSound.stop()
