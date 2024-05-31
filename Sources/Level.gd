extends Node3D

var player = null
@export var ambientSound : AudioStream
@export_range(-60, 10) var ambientVolume : float
@export var musicSound : AudioStream
@export_range(-60, 10) var musicVolume : float
@export var gamemode: Main.GameMode

var mushroom_count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()
	GameSfx.play_ambient(ambientSound)
	GameSfx.set_ambient_volume(ambientVolume)
	GameSfx.play_music(musicSound)
	GameSfx.set_music_volume(musicVolume)
	GlobalEvents.interacted_with.connect(_on_interacted_with)

func _on_interacted_with(_who, what):
	if what is MushroomInteractable:
		mushroom_count += 1
		print("Mushroom collected! Total: ", mushroom_count, "/", get_mushrooms_amount())
		if get_mushrooms_amount() == 1:
			GlobalEvents.collected_all_mushrooms.emit()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func get_mushrooms_amount():
	return $Mushrooms.get_child_count()


func spawn_player():
	var spawn_point = $PlayerSpawnPoint

	if spawn_point == null:
		push_error("Players spawn position not found on the level")
		return

	player = load("res://GameObjects/Player.tscn").instantiate()
	player.global_transform = spawn_point.global_transform
	player.get_node("Camera").current = true
	add_child(player)
	player.get_node("CanvasLayer/PlayerHud").set_mushrooms_amount(get_mushrooms_amount())
