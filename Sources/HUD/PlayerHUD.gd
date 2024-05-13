extends Control

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var healthBar : HealthBar = $HealthBar
@onready var interactionText : Label = $InteractionLabel
@export var character : Character

var interactable : Interactable
# Called when the node enters the scene tree for the first time.
func _ready():
	if character:
		character.health_changed.connect(healthBar.set_health)
		healthBar.set_max_health(character.characterStats.max_health)
	else:
		push_error("PlayerHUD requires a character to be set.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start_pet():
	animationPlayer.play("cat_start_pet")
	

func stop_pet():
	animationPlayer.play("cat_end_pet")

func set_interactable(_interactable : Interactable):
	interactable = _interactable
	interactionText.text = "Interact with (" + interactable.interactableName + ") to " + interactable.interactionPrompt 

func clear_interactable(_interactable : Interactable):
	interactable = null
	interactionText.text = ""

