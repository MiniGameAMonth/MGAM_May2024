extends Control

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@export var petInterface : Node2D

var interactable : Interactable
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start_pet():
	petInterface.visible = true
	animationPlayer.play("cat_start_pet")
	

func stop_pet():
	animationPlayer.play("cat_end_pet")
