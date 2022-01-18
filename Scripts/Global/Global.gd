extends Node
 
var who_paused : int
var paused := false
	
# Pause and play game
func pause_game(player_id):
	if paused:
		return
	
	paused = true
	who_paused = player_id
	
func continue_game():
	if !paused:
		return
	
	paused = false

# Overwrite add child to add child to children holder
func add_child(node, legible_unique_name: bool = false):
	$ChildrenHolder.add_child(node, legible_unique_name)
	

