@tool
extends Area2D

@export var upgrade_label : Label
@export var sprite : Sprite2D
@export var upgrade_strategy : BaseUpgradeStrategy:
	set(val):
		upgrade_strategy = val
		needs_update = true
		
@export var needs_update := false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = upgrade_strategy.texture
	upgrade_label.text = upgrade_strategy.upgrade_text
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = upgrade_strategy.texture
			upgrade_label.text = upgrade_strategy.upgrade_text
			needs_update = false
	
func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		if upgrade_strategy.isPlayerUpgrade:
			body.player_upgrades.append(upgrade_strategy)
		elif not upgrade_strategy.isPlayerUpgrade:
			body.bullet_upgrades.append(upgrade_strategy)
		queue_free()
