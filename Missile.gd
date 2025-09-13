extends Area2D
#class_name Bullet

@export var speed: float = 20.0 # pixels/sec
@export var max_lifetime: float = 5.0 # seconds
@export var damage: int = 10

var _velocity: Vector2 = Vector2.ZERO
var _lifetime: float = 0.0
var _shooter_id: int = -1

func fire(scene: Node, position: Vector2, target_rotation: float, shooter_id: int = -1, speed_override: float = -1.0):
	global_position = position
	rotation = target_rotation
	#var direction = Vector2.RIGHT.rotated(rotation)
	_velocity = Vector2.RIGHT.rotated(target_rotation) * (speed if speed_override == -1 else speed_override)
	_lifetime = 0.0
	_shooter_id = shooter_id
	scene.add_child(self)
	show()

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	if _velocity == Vector2.ZERO:
		return
	
	# TODO: Account for tunneling.
	
	position += _velocity * delta
	
	_lifetime += delta
	if _lifetime >= max_lifetime:
		queue_free()

func _on_body_entered(body: Node) -> void:
	_apply_hit(body, global_position)

func _apply_hit(body: Node, position: Vector2) -> void:
	# Don't hit yourself.
	if body.get_instance_id() == _shooter_id:
		return
	
	# TODO: Do something to players or others for damage.
	#		Can use callable methods like "apply_damage(damage)" or can direcly
	#		modify a "health" value like "body.health = max(0, body.health - damage)"
	
	# Play effects
	_run_hit_effects(position)

func _run_hit_effects(position: Vector2) -> void:
	# TODO: Do something here to indicate a hit (i.e. play sound, bullet die anime.
	#		or call a player animation.
	#		the player that will do a player animation.
	pass
