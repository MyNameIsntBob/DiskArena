extends Node2D

export (NodePath) var first_mount_path
export (NodePath) var last_mount_path

export (NodePath) var first_link_path
export (NodePath) var last_link_path


func _ready():
	var first_link = get_node(first_link_path)
	first_link.set_node_a("../" + first_mount_path)
	
	var last_link = get_node(last_link_path)
	last_link.set_node_b("../" + last_mount_path)
