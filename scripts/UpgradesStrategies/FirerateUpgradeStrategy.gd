class_name FirerateUpgradeStrategy
extends BaseUpgradeStrategy

@export var fire_rate_modifier := 2

func _ready() -> void:
	isPlayerUpgrade = true;

func apply_upgrade_to_player(player: Player):
	player.fire_rate_modifier /= fire_rate_modifier
	
func apply_upgrade_to_projectile(bullet: Bullet):
	pass
