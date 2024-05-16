extends Control

@onready var pettingAnimationPlayer : AnimationPlayer = $PettingAnimation/AnimationPlayer
@onready var healthBar : HealthBar = $HealthBar
@onready var mushroomBar : IconBar = $MushroomBar
@onready var interactionText : Label = $InteractionLabel
@onready var radar : Radar = $Radar

@export var character : Character


var interactable : Interactable
var pickedMushrooms : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if character:
		character.health_changed.connect(healthBar.set_health)
		healthBar.set_max_health(character.characterStats.max_health)
	else:
		push_error("PlayerHUD requires a character to be set.")

	#testing mushroom bar
	mushroomBar.set_max_icons(5) #to determine based on level
	mushroomBar.set_filled_icons(pickedMushrooms) 

	radar.center = character

	GlobalEvents.interacted_with.connect(_on_interacted_with)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start_pet():
	pettingAnimationPlayer.play("cat_start_pet")
	

func stop_pet():
	pettingAnimationPlayer.play("cat_end_pet")

func set_interactable(_interactable : Interactable):
	interactable = _interactable
	interactionText.text = "Interact with (" + interactable.interactableName + ") to " + interactable.interactionPrompt 

func clear_interactable(_interactable : Interactable):
	interactable = null
	interactionText.text = ""

func update_health_bar():
	healthBar.set_health(character.characterStats.health)

func update_mushroom_bar():
	mushroomBar.set_filled_icons(pickedMushrooms)

func _on_interacted_with(_who, _interactable):
	if _interactable is MushroomInteractable:
		pickedMushrooms += 1
		update_mushroom_bar()

