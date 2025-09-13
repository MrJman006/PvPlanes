extends Node2D

var bullet_scene: PackedScene = load("res://scenes/Bullet.tscn")
#var player_scene: PackedScene = load("res://Player.tscn")

func _ready() -> void:
	#var player_1 = player.new()
	#get_tree().current_scene.add_child(player_1)
	pass

#func _physics_process(delta: float) -> void:
	#look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("ui_accept"):
		#fire()
#
#func fire() -> void:
	#print("Fire!")
	#var bullet = bullet_scene.instantiate()
	#add_child(bullet)
	#bullet.fire(Vector2.UP.rotated(rotation), get_instance_id())
	
