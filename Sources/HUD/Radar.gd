class_name Radar
extends Control

@export var enemyIcon : PackedScene
@export var catIcon : PackedScene

@export var iconFloatDistance : int = 1

@export var radarRadiusInMeters : float = 15
@export var radarRadiusInPixels : float = 100

@onready var icon_container : Control = $Icons

var meterToPixelRatio : float :
	get:
		return radarRadiusInPixels / radarRadiusInMeters

var icons = {}

var center : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	icons[GroupNames.Enemies] = []
	icons[GroupNames.Cat] = []
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var enemies : Array[Node] = get_tree().get_nodes_in_group(GroupNames.Enemies)
	var cats : Array[Node] = get_tree().get_nodes_in_group(GroupNames.Cat)

	build_icons(icons[GroupNames.Enemies], enemies, enemyIcon)
	build_icons(icons[GroupNames.Cat], cats, catIcon)
	pass

func update_icon(icon : Control, _position : Vector3):
	var relativePosition = _position - center.global_transform.origin
	var ui_position = Vector2(relativePosition.x, relativePosition.z) * meterToPixelRatio
	
	var _rotation = center.global_transform.basis.get_euler().y
	icon.position = ui_position.rotated(_rotation)

	if icon.position.length() > radarRadiusInPixels:
		icon.position = icon.position.normalized() * (radarRadiusInPixels + iconFloatDistance)

func build_icons(_icons : Array, _trackers : Array, _iconScene : PackedScene):
	#add icons if needed
	for i in range(_trackers.size()):
		if i >= _icons.size():
			var icon = _iconScene.instantiate()
			icon_container.add_child(icon)
			_icons.append(icon)

	#remove extra icons
	while _icons.size() > _trackers.size():
		_icons[-1].queue_free()
		_icons.pop_back()

	#update icons
	for i in range(_icons.size()):
		update_icon(_icons[i], _trackers[i].global_transform.origin)
