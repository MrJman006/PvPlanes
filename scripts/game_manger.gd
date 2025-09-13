extends Node2D
@export var upgrade_scene = preload("res://scenes/upgrade.tscn")
@export var max_upgrade_count = 5

var current_upgrade_count = 0
 
var upgrades : Array[BaseUpgradeStrategy] = [
	preload("res://resources/strategies/Damage.tres"),
	preload("res://resources/strategies/FireRate.tres"),
	preload("res://resources/strategies/Health.tres"),
	preload("res://resources/strategies/Range.tres"),
	preload("res://resources/strategies/Shield.tres")
	]

func _ready() -> void:
	randomize()
	start_spawn_timer()

func start_spawn_timer():
	var wait_time = randf_range(10, 25)
	var timer = get_tree().create_timer(wait_time)
	timer.timeout.connect(spawn_node)
	
func spawn_node() -> void:
	if max_upgrade_count > current_upgrade_count:
		var upgrade_type = randi_range(0,4)
		var new_upgrade = upgrade_scene.instantiate()
		new_upgrade.upgrade_strategy = upgrades[upgrade_type]
	
		var x = randf_range(0, get_viewport_rect().size.x)
		var y = randf_range(0, get_viewport_rect().size.y)
		
		new_upgrade.position = Vector2(x,y)
		new_upgrade.tree_exited.connect(func():
			current_upgrade_count -= 1
		)
	
		add_child(new_upgrade)
		current_upgrade_count += 1	
	start_spawn_timer()
