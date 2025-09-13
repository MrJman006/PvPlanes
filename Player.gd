extends CharacterBody2D
class_name Player

var bullet_scene: PackedScene = preload("res://scenes/Bullet.tscn")

# What device id to listen to (default 0 = keyboard)
@export var device_id: int = 0

# Maximum total velocity of the player (units/s)
@export var max_velocity: float = 128.0

# Maximum total turn speed (deg/s)
@export var max_turn_speed: float = 90.0

# Maximum health
@export var max_health: int = 100

# Current health
var current_health: int = max_health

# Current shield
var current_shield: int = 0

# Fire rate (s)
@export var fire_rate: float = 1.0

# Fire rate modifier
var fire_rate_modifier: float = 1.0

# Gun cooldown Timer
@onready var gun_cooldown_timer: Timer = Timer.new()

# Ready function
func _ready() -> void:
	gun_cooldown_timer.one_shot = true
	add_child(gun_cooldown_timer)

# Process physics
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_weapon_actions(delta)

func handle_weapon_actions(delta: float) -> void:
	# Fire Input
	if Input.is_action_pressed("ui_primary_fire", device_id) and gun_cooldown_timer.is_stopped(): # Enter / Space
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.fire(global_position, rotation, get_instance_id())
		bullet.show()
		gun_cooldown_timer.start(fire_rate * fire_rate_modifier)

# Add shield to the player
func add_shield(shield: int) -> void:
	current_shield += shield

# Add health to the player, no more than max
func add_health(health: int) -> void:
	current_health = min(current_health + health, max_health)
	
# Applies damage to the player,
# first to the shield, then to the health
func apply_damage(damage: int) -> void:
	if damage <= 0:
		return
	
	var shield_before_damage = current_shield
	current_shield = max(current_shield - damage, 0)
	damage -= shield_before_damage - current_shield

	current_health = max(current_health - damage, 0)

# Handles inputs that affect movement
# and finalizes the position of the player 
func handle_movement(delta: float) -> void:
	# Movement input: rotation
	if Input.is_action_pressed("ui_left", device_id): # A
		rotation_degrees -= max_turn_speed * delta
	if Input.is_action_pressed("ui_right", device_id): # D
		rotation_degrees += max_turn_speed * delta
	
	# Calculate new velocity
	velocity = Vector2.from_angle(rotation) * max_velocity
	
	# Apply movement
	position += velocity * delta
