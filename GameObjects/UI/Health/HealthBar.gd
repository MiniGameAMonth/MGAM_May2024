class_name HealthBar
extends IconBar

func _ready():
	pass

func _process(_delta):
	pass

func set_max_health(max_health: int):
	set_max_icons(max_health)

func set_health(health: int):
	set_filled_icons(health)
