extends RigidBody2D

export var player_id : int

var scores_to_text := ['1st\n', '2nd\n', '3rd\n', '4th\n']

func set_score():
	var character_id = ScoreKeeper.get_character_id(player_id)
	if character_id == null:
		return
	
	var score = scores_to_text[int(ScoreKeeper.get_score(player_id))]
	var deaths = str(ScoreKeeper.get_deaths(player_id)) + '\n'
	var kills = str(ScoreKeeper.get_kills(player_id)) + '\n'
	find_node('Scores').text = score + kills + deaths
	
	$Image.texture = Icons.get_gui_character(character_id)
	
