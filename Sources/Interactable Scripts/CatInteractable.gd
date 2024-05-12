class_name CatInteractable
extends Interactable

@export var pet_time_to_heal : float = 2.5

var pet_timer : Timer

var isPetting : bool = false
var to_heal : Character

func _ready():
	pet_timer = Timer.new()
	pet_timer.set_wait_time(pet_time_to_heal)
	pet_timer.connect("timeout",  heal)
	add_child(pet_timer)

func _process(_delta):
	if isPetting and pet_timer.wait_time == 0:
		pet_timer.start(pet_time_to_heal)

func heal():
	to_heal.heal(1)

func interact(_who):
	var animationPlayer = _who.get_node("AnimationPlayer")
	animationPlayer.play("pet_animation")
	to_heal = _who.get_node("Character")
	isPetting = true
	pet_timer.start(pet_time_to_heal)
	print("Petting")
	#stop cat
	#play animation
	#play sound
	#continue

func stop_interact(_who):
	if isPetting:
		var animationPlayer = _who.get_node("AnimationPlayer")
		animationPlayer.play("stop_pet_animation")
	isPetting = false
	pet_timer.stop()
	#stop cat
	#play animation
	#play sound
	#continue
