extends RigidBody2D

export (Texture) var normal_texture
export (Texture) var focused_texture

export (NodePath) var neighbour_left
export (NodePath) var neighbour_top
export (NodePath) var neighbour_right
export (NodePath) var neighbour_bottom

export (NodePath) var button
export (NodePath) var sprite

signal pressed


func _ready():
	sprite().texture = normal_texture
	_setup_neighbours()


func button():
	return get_node(button)


func sprite():
	return get_node(sprite)


func _setup_neighbours() -> void:
	if neighbour_left:
		button().focus_neighbour_left = get_node(neighbour_left).button
	if neighbour_top:
		button().focus_neighbour_top = get_node(neighbour_top).button
	if neighbour_right:
		button().focus_neighbour_right = get_node(neighbour_right).button
	if neighbour_bottom:
		button().focus_neighbour_bottom = get_node(neighbour_bottom).button


func _on_focus_entered():
	sprite().texture = focused_texture


func _on_focus_exited():
	sprite().texture = normal_texture


func _on_Button_pressed():
	emit_signal("pressed")
