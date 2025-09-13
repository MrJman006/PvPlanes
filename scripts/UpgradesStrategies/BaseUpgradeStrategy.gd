class_name BaseUpgradeStrategy
extends Resource

# Sprite varabile
@export var texture : Texture2D = preload("res://assests/Generic_Upgrade.png")
@export var upgrade_text : String = "Upgrade"
@export var isPlayerUpgrade : bool = false

func apply_upgrade_to_player(player: Player):
	pass
	
func apply_upgrade_to_projectile(bullet: Bullet):
	pass
