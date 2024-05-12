class_name HealthBar
extends Control

var healthHeart : PackedScene = preload("res://GameObjects/UI/Health/HealthHeart.tscn")
@onready var container : HBoxContainer = $HeartContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_max_health(max_health: int):
	for i in range(max_health):
		var heart = healthHeart.instantiate()
		container.add_child(heart)

func set_health(health: int):
	for i in range(container.get_child_count()):
		var heart = container.get_child(i)
		if i < health:
			heart.show()
		else:
			heart.hide()
