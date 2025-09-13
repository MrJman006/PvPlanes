extends Node2D
signal go_to_player_menu()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_button: TextureButton = $StartButton
@onready var quit_button: TextureButton = $QuitButton
var selectedButton: TextureButton
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	animation_player.play("pulsate")
	selectedButton = start_button
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("controller_one_down") or Input.is_action_just_pressed("controller_one_up"):
		if selectedButton == quit_button:
			selectedButton.release_focus()
			selectedButton = start_button
			selectedButton.grab_focus()
		elif selectedButton == start_button:
			selectedButton.release_focus()
			selectedButton = quit_button
			selectedButton.grab_focus()
	
	if Input.is_action_just_pressed("controller_one_confirm") or Input.is_action_just_pressed("mb_select"):
		get_tree().change_scene_to_file("res://scenes/PlayerMenu.tscn")
		
