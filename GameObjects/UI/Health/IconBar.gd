class_name IconBar
extends Control

@export var icon : PackedScene
@onready var container : Node = $Container

# Called when the node enters the scene tree for the first time.
func _ready():
	#added an icon for preview purposes
	for child in container.get_children():
		child.free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_max_icons(max_health: int):
	for child in container.get_children():
		child.queue_free()

	for i in range(max_health):
		var new_icon = icon.instantiate()
		container.add_child(new_icon)

func set_filled_icons(filled_icons: int):
	for i in range(container.get_child_count()):
		var _icon : FillableIcon = container.get_child(i)
		if i < filled_icons:
			_icon.set_filled()
		else:
			_icon.set_empty()
