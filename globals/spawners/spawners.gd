extends Node2D

export (NodePath) var TopLeft
export (NodePath) var BottomRight

var rng = RandomNumberGenerator.new()

var _top_left
var _bottom_right

func _ready():
	rng.randomize()
	_top_left = get_node(TopLeft)
	_bottom_right = get_node(BottomRight)
	

func random_spawn_position() -> Vector2:
	var pos = Vector2.ZERO
	pos.x = rng.randf_range(_top_left.position.x, _bottom_right.position.x)
	pos.y = rng.randf_range(_bottom_right.position.y, _top_left.position.y)
	return pos
