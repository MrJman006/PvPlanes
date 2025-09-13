extends TextureButton

func _on_pressed() -> void:
	get_tree().quit()

func _on_mouse_entered() -> void:
	release_focus() # Replace with function body.
