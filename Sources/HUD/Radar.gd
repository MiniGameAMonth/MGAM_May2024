class_name Radar
extends Control

@export var enemyIcon : PackedScene
@export var catIcon : PackedScene

@export var iconFloatDistance : int = 1

@export var radiusInMeters : float = 15
@export var radiusInPixels : float = 100
@export var maxDistanceInMeters : float = 20

@onready var icon_container : Control = $Icons

var meterToPixelRatio : float :
	get:
		return radiusInPixels / radiusInMeters

var icons = {}

var center : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	icons[GroupNames.Enemies] = []
	icons[GroupNames.Cat] = []

func _process(_delta):
	var enemies : Array[Node] = get_tree().get_nodes_in_group(GroupNames.Enemies)
	var cats : Array[Node] = get_tree().get_nodes_in_group(GroupNames.Cat)

	build_icons(icons[GroupNames.Enemies], enemies, enemyIcon)
	build_icons(icons[GroupNames.Cat], cats, catIcon)

func update_icon(icon : Control, _position : Vector3):
	var relativePosition = _position - center.global_transform.origin
	var ui_position = Vector2(relativePosition.x, relativePosition.z) * meterToPixelRatio
	
	var _rotation = center.global_transform.basis.get_euler().y
	icon.position = ui_position.rotated(_rotation)

	if icon.position.length() > maxDistanceInMeters * meterToPixelRatio:
		icon.visible = false
	else:
		icon.visible = true

	if icon.position.length() > radiusInPixels:
		icon.position = icon.position.normalized() * (radiusInPixels + iconFloatDistance)
	

func build_icons(_icons : Array, _trackers : Array, _iconScene : PackedScene):
	if _trackers.size() - _icons.size() > 0:
		for i in range(_trackers.size() - _icons.size()):
			var icon = _iconScene.instantiate()
			icon_container.add_child(icon)
			_icons.append(icon)
	elif _trackers.size() - _icons.size() < 0:
		for i in range(_icons.size() - _trackers.size()):
			_icons[-1].queue_free()
			_icons.pop_back()

	#update icons
	for i in range(_icons.size()):
		update_icon(_icons[i], _trackers[i].global_transform.origin)
