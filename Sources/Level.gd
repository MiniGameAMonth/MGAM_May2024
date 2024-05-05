extends Node3D

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()
	Main.start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_player():
	var spawn_point = $PlayerSpawnPoint

	if spawn_point == null:
		push_error("Player spawn position not found on the level")

	player = load("res://GameObjects/Player.tscn").instantiate()
	player.global_transform = spawn_point.global_transform
	player.get_node("Camera").current = true
	add_child(player)