extends CharacterBody2D
class_name Player

var bullet_scene: PackedScene = preload("res://scenes/Bullet.tscn")
var missile_scene: PackedScene = preload("res://scenes/Missile.tscn")

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

# Missiles
var _missile_count: int = 2
@export var missile_rate: float = 1.0
@onready var missile_cooldown_timer: Timer = Timer.new()

# Ready function
func _ready() -> void:
	gun_cooldown_timer.one_shot = true
	add_child(gun_cooldown_timer)
	
	missile_cooldown_timer.one_shot = true
	add_child(missile_cooldown_timer)

# Process physics
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_weapon_actions(delta)

func handle_weapon_actions(delta: float) -> void:
	handle_bullet_fire(delta)
	handle_missile_fire(delta)

func handle_bullet_fire(delta: float) -> void:
	if Input.is_action_pressed("ui_primary_fire", device_id) and gun_cooldown_timer.is_stopped(): # Enter / Space
		var bullet = bullet_scene.instantiate()
		var root_scene = get_tree().current_scene
		bullet.fire(root_scene, global_position, rotation, get_instance_id())
		gun_cooldown_timer.start(fire_rate * fire_rate_modifier)

func handle_missile_fire(delta:float) -> void:
	if Input.is_action_just_pressed("ui_secondary_fire", device_id) \
		and missile_cooldown_timer.is_stopped() \
		and _missile_count != 0:
			_missile_count -= 1
			# Hide the appropriate missile on the player.
			var missile_sprite = get_node("SpriteBoundingBox/LeftMissile") if _missile_count == 1 else get_node("SpriteBoundingBox/RightMissile")
			missile_sprite.hide()
			
			# Create a missile instance and fire it.
			var root_scene = get_tree().current_scene
			var missile = missile_scene.instantiate()
			missile.fire(root_scene, missile_sprite.global_position, rotation, get_instance_id())
			
			# Start the fire cooldown
			missile_cooldown_timer.start(fire_rate * fire_rate_modifier)
			print("Fire...MISSILE!")

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
	
	handle_screen_wrap()

func handle_screen_wrap() -> void:
	var screen_size = get_viewport().get_visible_rect().size

	var sprite_bounding_box = get_node("SpriteBoundingBox").get_shape().size
	
	if position.x - sprite_bounding_box.x >= screen_size.x:
		position.x = 0
	elif position.x <= -sprite_bounding_box.x:
		position.x = screen_size.x
	
	if position.y - sprite_bounding_box.y >= screen_size.y:
		position.y = 0
	elif position.y <= -sprite_bounding_box.y:
		position.y = screen_size.y
