extends Node
 
var who_paused : int
var paused := false
var game_over := false

# TODO 
# Implement this
var can_shoot := false


func pause_game(player_id):
	if paused or game_over:
		return
	
	paused = true
	who_paused = player_id
	$PauseSign.drop()


func continue_game():
	if !paused:
		return
	
	paused = false


func game_over():
	game_over = true
	$GameOverSign.drop()
	yield($GameOverSign, 'finished')


func restart():
	game_over = false
	ScoreKeeper.reset_game()


func exit():
	game_over = false
	SceneManager.load_main_menu()



# Overwrite add child to add child to children holder
func add_child(node, legible_unique_name: bool = false):
	$ChildrenHolder.add_child(node, legible_unique_name)


func remove_children():
	for node in $ChildrenHolder.get_children():
		node.queue_free()


func get_children():
	$ChildrenHolder.get_children()


func focus_camera():
	$Camera2D.current = true


func set_hp_bars():
	$Interface.set_hp_bars()


func set_scores():
	$GameOverSign.set_scores()


