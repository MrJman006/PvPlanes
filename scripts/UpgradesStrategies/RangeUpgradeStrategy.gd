class_name RangeUpgradeStrategy
extends BaseUpgradeStrategy

@export var range_increase := .01

func _ready() -> void:
	isPlayerUpgrade = false;

func apply_upgrade_to_projectile(bullet: Bullet):
	bullet.max_lifetime += range_increase
