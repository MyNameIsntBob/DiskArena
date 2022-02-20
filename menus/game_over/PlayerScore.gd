extends RigidBody2D

export var player_id : int
var character_id

export (NodePath) var character_texture_path
var character_texture : TextureRect
export (NodePath) var place_text_path
var place_text : Label
export (NodePath) var scores_text_path
var scores_text : Label

var place_to_text := ['\n1st', '\n2nd', '\n3rd', '\n4th']

func _ready():
	character_texture = get_node(character_texture_path)
	place_text = get_node(place_text_path)
	scores_text = get_node(scores_text_path)

func set_score():
	if !character_valid():
		return
	
	set_character()
	set_place()
	update_score()


func set_character():
	character_texture.texture = Icons.get_gui_character(character_id)


func set_place():
	var place = place_to_text[int(ScoreKeeper.get_score(player_id))]
	place_text.text = place


func update_score():
	var deaths = str(ScoreKeeper.get_deaths(player_id)) + '\n'
	var kills = str(ScoreKeeper.get_kills(player_id)) + '\n'
	scores_text.text = kills + deaths
	scores_text.margin_top = 7


func character_valid():
	character_id = ScoreKeeper.get_character_id(player_id)
	var image = $Image/VBoxContainer
	if character_id == null:
		if is_instance_valid(image):
			image.hide()
		return false
	
	if is_instance_valid(image):
		image.show()
	return true

