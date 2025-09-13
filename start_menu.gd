extends Node

@onready var start_button: TextureButton = $StartButton
@onready var quit_button: TextureButton = $QuitButton
var selectedButton: TextureButton
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
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
	
	if Input.is_action_just_pressed("device_0_confirm"):
		selectedButton.emit_signal("pressed")
		
