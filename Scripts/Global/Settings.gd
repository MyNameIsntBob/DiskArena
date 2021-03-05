extends Node

var fullScreen = false
var save_path = 'user://save.dat'

func _ready():
	load_game()
	
func set_full_screen(value):
	fullScreen = !!value
	OS.window_fullscreen = !!value

func save_game():
	var data = {
		'fullScreen': fullScreen
#		'powers': {
#
#		}
	}
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	
	if error == OK:
		file.store_var(data)
		file.close()

func load_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			file.close()
			
			set_full_screen(data["fullScreen"])
