extends CharacterBody2D
class_name Player

var bullet_scene: PackedScene = preload("res://scenes/Bullet.tscn")

# Maximum total velocity of the player (units/s)
@export var max_velocity := 96

# Maximum total turn speed (deg/s)
@export var max_turn_speed := 90

# Maximum health
@export var max_health := 100

# Cooldown limit for bullets
@export var bullet_cooldown_limit: float = 0.3

# Current Health
@export var current_health := max_health

# Cooldown timer for bullets.
var _bullet_cooldown: float = 0.0

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_weapon_actions(delta)

func handle_movement(delta: float) -> void:
	# Movement input: rotation
	if Input.is_action_pressed("ui_left"): # A
		rotation_degrees -= max_turn_speed * delta
	if Input.is_action_pressed("ui_right"): # D
		rotation_degrees += max_turn_speed * delta
	
	# Calculate new velocity
	velocity = Vector2.from_angle(rotation) * max_velocity
	
	# Apply movement
	position += velocity * delta
	#print("Position: ", position, " Velocity: ", velocity, " Heading: ", rotation_degrees)

func handle_weapon_actions(delta: float) -> void:
	_bullet_cooldown = max(0, _bullet_cooldown - delta)
	if _bullet_cooldown == 0 and Input.is_action_pressed("ui_primary_fire"):
		_bullet_cooldown = bullet_cooldown_limit
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.fire(global_position, rotation, get_instance_id())
		bullet.show()
