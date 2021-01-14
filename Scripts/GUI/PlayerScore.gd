extends VBoxContainer

export var player_id : int

var scores_to_text := ['1st\n', '2nd\n', '3rd\n', '4th\n']

func _ready():
	var character_id = Global.get_character_id(player_id)
	if character_id == null:
		return
	
	var score = scores_to_text[int(Global.get_score(player_id))]
	var deaths = str(Global.get_deaths(player_id)) + '\n'
	var kills = str(Global.get_kills(player_id)) + '\n'
	find_node('Label2').text = score + kills + deaths
	
	$Image.texture = Icons.get_gui_character(character_id)
	
