class_name CatInteractable
extends Interactable

@export var pet_time_to_heal : float = 2.5

@export var graphics : SpriteBase3D

var pet_timer : Timer

var isPetting : bool = false
var to_heal : Character
var animationEnd : Callable

func _ready():
	super._ready()
	pet_timer = Timer.new()
	pet_timer.set_wait_time(pet_time_to_heal)
	pet_timer.one_shot = false
	pet_timer.connect("timeout",  heal)
	add_child(pet_timer)

func _process(_delta):
	pass

func heal():
	to_heal.heal(1)

func interact(_who):
	var animationPlayer = _who.get_node("AnimationPlayer")
	animationPlayer.play("pet_animation")

	to_heal = _who.get_node("Character")
	isPetting = true
	pet_timer.start(pet_time_to_heal)

	graphics.visible = false
	#stop cat
	#play sound

func stop_interact(_who):
	if isPetting:
		GlobalEvents.player_stopped_petting.emit()
		var animationPlayer = _who.get_node("AnimationPlayer")
		animationEnd = Callable(
			func(_x):
				graphics.visible = true
				animationPlayer.disconnect("animation_finished", animationEnd)
		)
		animationPlayer.play("stop_pet_animation")
		animationPlayer.connect("animation_finished", animationEnd)
	isPetting = false
	pet_timer.stop()

	
	#start cat
	#play sound
