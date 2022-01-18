extends RigidBody2D

export var player_id : int

export (NodePath) var place 
export (NodePath) var scores

var scores_to_text := ['1st', '2nd', '3rd', '4th']

func _ready():
	set_background()
	set_scores()
	set_character()

func set_background():
	$Sprite.texture = load("res://Art/GUI/Signs/CharacterSelect/CharacterBox" + str(player_id) + ".png")	

func set_scores():
	var score = scores_to_text[int(Global.get_score(player_id))]
	var deaths = Global.get_deaths(player_id)
	var kills = Global.get_kills(player_id)
	get_node(place).text = str(score) + ' place'
	get_node(scores).text = str(deaths) + '\n' + str(kills)

func set_character():
	var character_id = Global.get_character_id(player_id)
	if character_id == null:
		return
	
	$Image.texture = Icons.get_gui_character(character_id)
