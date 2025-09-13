extends Node

var players = [0,0,0,0]
@onready var player_one_join_button: TextureButton = $PlayerOneJoinButton
@onready var player_two_join_button: TextureButton = $PlayerTwoJoinButton
@onready var player_three_join_button: TextureButton = $PlayerThreeJoinButton
@onready var player_four_join_button: TextureButton = $PlayerFourJoinButton

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("device_0_confirm"):
		player_one_join_button.visible = false
		players[0] = 1
		for i in players:
			print(i)
	if Input.is_action_just_pressed("device_1_confirm"):
		player_two_join_button.visible = false
		players[1] = 1
	if Input.is_action_just_pressed("device_2_confirm"):
		player_three_join_button.visible = false
		players[2] = 1
	if Input.is_action_just_pressed("device_3_confirm"): 
		player_four_join_button.visible = false
		players[4] = 1
		
	if Input.is_action_just_pressed("device_0_back"):
		player_one_join_button.visible = true
		players[0] = 0
	if Input.is_action_just_pressed("device_1_back"):
		player_two_join_button.visible = true
		players[1] = 0
	if Input.is_action_just_pressed("device_2_back"):
		player_three_join_button.visible = true
		players[2] = 0
	if Input.is_action_just_pressed("device_3_back"): 
		player_four_join_button.visible = true
		players[4] = 0
