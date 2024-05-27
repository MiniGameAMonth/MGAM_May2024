class_name PlayerHUD
extends Control

signal on_label_changed(new_label : String)

@onready var pettingAnimationPlayer : AnimationPlayer = $PettingAnimation/AnimationPlayer
@onready var healthBar : HealthBar = $HealthBar
@onready var mushroomBar : IconBar = $MushroomBar
@onready var interactionText : Label = $InteractionLabel
@onready var radar : Radar = $Radar
@onready var handAnimationPlayer : AnimationPlayer = $Hand/AnimationPlayer

@export var character : Character
@export var blinks_on_damage : int = 3


var interactable : Interactable
var pickedMushrooms : int = 0
var wandCallable : Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	if character:
		character.health_changed.connect(healthBar.set_health)
		character.damaged.connect(blink_radar)
		healthBar.set_max_health(character.characterStats.max_health)
	else:
		push_error("PlayerHUD requires a character to be set.")

	#testing mushroom bar
	set_mushrooms_amount(5)

	radar.center = character

	GlobalEvents.interacted_with.connect(_on_interacted_with)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func set_mushrooms_amount(amount):
	mushroomBar.set_max_icons(amount)
	mushroomBar.set_filled_icons(pickedMushrooms) 


func start_pet():
	pettingAnimationPlayer.play("cat_start_pet")
	

func stop_pet():
	pettingAnimationPlayer.play("cat_end_pet")

func set_interactable(_interactable : Interactable):
	interactable = _interactable
	interactionText.text = "Interact with (" + interactable.interactableName + ") to " + interactable.interactionPrompt 
	on_label_changed.emit(interactionText.text)

func clear_interactable(_interactable : Interactable):
	interactable = null
	interactionText.text = ""
	on_label_changed.emit(interactionText.text)

func update_health_bar():
	healthBar.set_health(character.characterStats.health)

func update_mushroom_bar():
	mushroomBar.set_filled_icons(pickedMushrooms)

func _on_interacted_with(_who, _interactable):
	if _interactable is MushroomInteractable:
		pickedMushrooms += 1
		update_mushroom_bar()

func play_wand_animation(animation : String, callback : Callable):
	handAnimationPlayer.play(animation)
	wandCallable = callback

func on_wand_shoot():
	wandCallable.call()

func blink_radar(_damage):
	radar.start_blink_wizard_outline(blinks_on_damage)

