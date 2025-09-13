class_name ShieldUpgradeStrategy
extends BaseUpgradeStrategy

@export var shield_value := 25

func _ready() -> void:
	isPlayerUpgrade = true;

func apply_upgrade_to_player(player: Player):
	player.add_shield(shield_value)
	
func apply_upgrade_to_projectile(bullet: Bullet):
	pass
