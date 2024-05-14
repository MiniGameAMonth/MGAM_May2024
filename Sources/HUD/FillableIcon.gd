class_name FillableIcon
extends Control

@onready var silhouette : Control = $Silhouette
@onready var empty : TextureRect = $Empty
@onready var filled : TextureRect = $Full


func _ready():
	pass

func set_empty():
	empty.visible = true
	filled.visible = false

func set_filled():
	empty.visible = false
	filled.visible = true

func set_silhouette_visible(vis : bool):
	silhouette.visible = vis
