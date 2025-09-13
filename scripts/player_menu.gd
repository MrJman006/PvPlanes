extends Node

enum PLAYER
{
	ONE,
	TWO,
	THREE,
	FOUR
}
var players = [0,0,0,0]
var ready_players = [0,0,0,0]
var game_ready = false

@onready var player_one_button: Sprite2D = $PlayerOne/PlayerOneButton
@onready var player_one_label: Label = $PlayerOne/PlayerOneLabel
@onready var check_box_one: TextureRect = $PlayerOne/CheckBoxOne
@onready var player_two_button: Sprite2D = $PlayerTwo/PlayerTwoButton
@onready var check_box_two: TextureRect = $PlayerTwo/CheckBoxTwo
@onready var player_three_button: Sprite2D = $PlayerThree/PlayerThreeButton
@onready var check_box_three: TextureRect = $PlayerThree/CheckBoxThree
@onready var player_four_button: Sprite2D = $PlayerFour/PlayerFourButton
@onready var check_box_four: TextureRect = $PlayerFour/CheckBoxFour
@onready var check_one: TextureRect = $PlayerOne/CheckOne
@onready var check_two: TextureRect = $PlayerTwo/CheckTwo
@onready var check_three: TextureRect = $PlayerThree/CheckThree
@onready var check_four: TextureRect = $PlayerFour/CheckFour

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_ready:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/GameScene.tscn")	
	# PLAYER ONE ACTIONS
	if Input.is_action_just_pressed("kb_space"):
		players[PLAYER.ONE] = 1
		player_one_button.visible = false
		check_box_one.visible = true
	if Input.is_action_just_pressed("kb_escape"):
		if ready_players[PLAYER.ONE] == 1:
			check_one.visible = false
			ready_players[PLAYER.ONE] = 0
		else:
			players[PLAYER.ONE] = 0
			player_one_button.visible = true
			check_box_one.visible = false
	if Input.is_action_just_pressed("kb_enter"):
		ready_players[PLAYER.ONE] = 1
		check_one.visible = true
		if players == ready_players:
			game_ready = true
		
	# PLAYER TWO ACTIONS
	if Input.is_action_just_pressed("controller_one_confirm"):
		players[PLAYER.TWO] = 1
		player_two_button.visible = false
		check_box_two.visible = true
	if Input.is_action_just_pressed("controller_one_return"):
		if ready_players[PLAYER.TWO] == 1:
			check_two.visible = false
			ready_players[PLAYER.TWO] = 0
		else:
			players[PLAYER.TWO] = 1
			player_two_button.visible = true
			check_box_two.visible = false
	if Input.is_action_just_pressed("controller_one_start"):
		ready_players[PLAYER.TWO] = 1
		check_two.visible = true
		if players == ready_players:
			game_ready = true
	# PLAYER THREE ACTIONS
	if Input.is_action_just_pressed("controller_two_confirm", ):
		players[PLAYER.THREE] = 1
		player_three_button.visible = false
		check_box_three.visible = true
	if Input.is_action_just_pressed("controller_two_return"):
		if ready_players[PLAYER.THREE] == 1:
			check_three.visible = false
			ready_players[PLAYER.THREE] = 0
		else:
			players[PLAYER.THREE] = 2
			player_three_button.visible = true
			check_box_three.visible = false
	if Input.is_action_just_pressed("controller_two_start"):
		ready_players[PLAYER.THREE] = 1
		check_three.visible = true
		if players == ready_players:
			game_ready = true
	# PLAYER FOUR ACTIONS
	if Input.is_action_just_pressed("controller_three_confirm"): 
		players[PLAYER.FOUR] = 1
		player_four_button.visible = false
		check_box_four.visible = true
	if Input.is_action_just_pressed("controller_three_return"):
		if ready_players[PLAYER.FOUR] == 1:
			check_four.visible = false
			ready_players[PLAYER.FOUR] = 0
		else:
			players[PLAYER.FOUR] = 3
			player_four_button.visible = true
			check_box_four.visible = false
	if Input.is_action_just_pressed("controller_three_start"):
		ready_players[PLAYER.FOUR] = 1
		check_four.visible = true	
		if players == ready_players:
			game_ready = true
