extends Node2D

var player_scene: PackedScene = preload("res://scenes/Player.tscn")
var players : Array
func _ready() -> void:
	players = Manager.players
	spawn_players(players)

func spawn_players(players: Array) -> void:
	for i in range(players.size()):
		if players[i] == true:
			var new_player = player_scene.instantiate()
			var random_pos = Vector2(randi_range(0,800),randi_range(0,800))
			new_player.global_position = random_pos
			add_child(new_player)
