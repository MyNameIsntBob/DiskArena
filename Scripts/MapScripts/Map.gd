extends Node2D

var counter : float
var spawned := false

export(Array, NodePath) var spawn_locations

export(NodePath) var map2
export(NodePath) var map4

#Change spawn location node paths to spawn location 
func _ready():
	for i in range(len(spawn_locations)):
		spawn_locations[i] = get_node(spawn_locations[i])
	
#	$Map.texture = Icons.get_map(Global.number_of_players)
	if ScoreKeeper.num_of_players < 3:
		if map4:
			get_node(map2).visible = true
			get_node(map4).queue_free()
	else:
		if map2:
			get_node(map4).visible = true
			get_node(map2).queue_free()
	
