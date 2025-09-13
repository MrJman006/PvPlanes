extends CharacterBody2D
class_name Player

# Maximum total velocity of the player (units/s)
@export var max_velocity := 96

# Maximum total turn speed (deg/s)
@export var max_turn_speed := 90

# Maximum health
@export var max_health := 100

# Current Health
@export var current_health := max_health

func _physics_process(delta: float) -> void:
	handle_movement(delta)

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
