extends Node2D

export (NodePath) var TopLeft
var top_left
export (NodePath) var BottomRight
var bottom_right
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	top_left = get_node(TopLeft)
	bottom_right = get_node(BottomRight)
	

func random_spawn_position() -> Vector2:
	var pos = Vector2.ZERO
	pos.x = rng.randf_range(top_left.position.x, bottom_right.position.x)
	pos.y = rng.randf_range(bottom_right.position.y, top_left.position.y)
	return pos

func activate_power_spawner():
	$PowerSpawner.activate()
	
func add_characters(num_of_bots):
	$PlayerSpawner.add_characters(num_of_bots)
