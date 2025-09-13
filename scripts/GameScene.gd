extends Node2D

var player_scene: PackedScene = preload("res://Player.tscn")

func _ready() -> void:
	var player_1 = player_scene.instantiate()
	player_1.global_position = Vector2(500, 250)
	get_tree().current_scene.add_child(player_1)
	player_1.show()
