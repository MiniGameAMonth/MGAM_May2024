extends Character

@export var follower : Follower
@export var weapon : Weapon
@onready var detectionArea : Area3D = %DetectionArea

func _ready():
	if (follower == null) or (weapon == null):
		print("Follower or Weapon not set in Inspector")

func _process(_delta):
	if follower.followTarget != null:

		if weapon.is_target_in_range(follower.followTarget):
			weapon.try_deal_damage(follower.followTarget)
	

func _on_detection_area_body_entered(body:Node3D):
	follower.followTarget = body

func turn_to_mushroom(): #turns the enemy into a mushroom on death (when mushroom is implemented)
	pass

