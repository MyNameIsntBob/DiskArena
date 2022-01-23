extends Node
 
var who_paused : int
var paused := false
var game_over := false


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


func game_over():
	game_over = true
	$GameOverSign.set_scores()
	$GameOverSign.drop()
	yield($GameOverSign, 'finished')

# Overwrite add child to add child to children holder
func add_child(node, legible_unique_name: bool = false):
	$ChildrenHolder.add_child(node, legible_unique_name)


func remove_children():
	for node in $ChildrenHolder.get_children():
		node.queue_free()


func focus_camera():
	$Camera2D.current = true


func set_hp_bars():
	$Interface.set_hp_bars()


