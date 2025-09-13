extends Node2D

const GAME_SCENE = preload("res://scenes/GameScene.tscn")

var next_scene_instance = null

var players : Array = []
# Function to prepare the next scene before changing to it
func prepare_game_scene(new_players: Array):
	players = new_players
	get_tree().change_scene_to_file("res://scenes/GameScene.tscn")
	#next_scene_instance = GAME_SCENE.instantiate()
	#if next_scene_instance.has_method("add_players"):
		#next_scene_instance.add_players(players)
#
## Function to perform the scene change
#func start_game():
	#if next_scene_instance:
		#get_tree().change_scene_to_packed(next_scene_instance)
		#next_scene_instance = null
