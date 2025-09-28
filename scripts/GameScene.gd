extends Node2D

var player_scene: PackedScene = preload("res://scenes/Player.tscn")
var players : Array
func _ready() -> void:
	players = Manager.players
	spawn_players(players)

func spawn_players(players: Array) -> void:
	var device_id = 0
	for i in range(players.size()):
		if players[i] == true:
			var new_player = player_scene.instantiate()
			new_player.set_device_id(device_id)
			device_id += 1
			add_child(new_player)
			new_player.global_position = Vector2(randi_range(0,800),randi_range(0,800))
