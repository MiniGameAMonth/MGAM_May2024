class_name RangedWeapon
extends Weapon

@export var attackDistance : float = 10

var bullet;

func _ready():
	bullet = preload("res://GameObjects/Projectile.tscn")
	if bullet == null:
		push_error("Projectile is not set.")

func in_range(_target : Node3D):
	var distance = global_position.distance_to(_target.global_position)
	return distance <= attackDistance

func attack():
	if can_attack():
		shoot() #maybe shoot towards target
	if playSoundOnAttack:
		play_weapon_sound()

func shoot():
	var bulletInstance : Projectile = bullet.instantiate()
	get_tree().root.add_child(bulletInstance)
	bulletInstance.global_position = global_position
	bulletInstance.set_direction(global_transform.basis.z)
	bulletInstance.damage = weaponDamage

	if GC.get_config_value("Config", "UseAutoAim", false):
		var angle = GC.get_config_value("Config", "AutoAimZone", 10)
		print("Autoaiming with angle: " + str(angle))
		var target = autoaim(angle, bulletInstance)
		if target != null:
			bulletInstance.set_target(target)
		else:
			bulletInstance.set_direction(global_transform.basis.z)

	if playSoundOnAttack:
		play_weapon_sound()
	cooldown.start(cooldownTime)

var projectileWidth = 10.0 / Projected2DNode.PIXEL_PER_METER

func autoaim(degrees: float, _bullet: Projectile):
	var rads = degrees / 180.0 * PI
	var half = sin(rads/2) * 50
	var distance = half*2
	var steps = distance/projectileWidth
	var anglePerStep = rads/steps
	var targets = []
	for i in range(steps):
		var direction = global_transform.basis.z.rotated(Vector3(0,1,0), anglePerStep*(i - steps/2))
		_bullet.set_direction(direction)
		if _bullet.target != null:
			print("Target acquired")
			targets.append(_bullet.target)
	
	var closestTarget = null
	var closestDistance = 1000000
	for target in targets:
		var distance_to_target = global_position.distance_to(target.global_position)
		if distance_to_target < closestDistance:
			closestDistance = distance
			closestTarget = target
	return closestTarget

		
		
