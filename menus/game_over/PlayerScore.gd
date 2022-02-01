extends RigidBody2D

export var player_id : int

export (NodePath) var character_texture_path
var character_texture : TextureRect
export (NodePath) var place_text_path
var place_text : Label
export (NodePath) var scores_text_path
var scores_text : Label

var place_to_text := ['1st\n', '2nd\n', '3rd\n', '4th\n']

func _ready():
	character_texture = get_node(character_texture_path)
	place_text = get_node(place_text_path)
	scores_text = get_node(scores_text_path)

func set_score():
	set_character()
	if ScoreKeeper.get_score(player_id) == null:
		break_chain()
		return
	
	var place = place_to_text[int(ScoreKeeper.get_score(player_id))]
	place_text.text = place
	var deaths = str(ScoreKeeper.get_deaths(player_id)) + '\n'
	var kills = str(ScoreKeeper.get_kills(player_id)) + '\n'
	scores_text.text = kills + deaths
	scores_text.margin_top = 0


func set_character():
	var character_id = ScoreKeeper.get_character_id(player_id)
	if character_id == null:
		return
	
	character_texture.texture = Icons.get_gui_character(character_id)
	

func break_chain():
	if is_instance_valid($Image/VBoxContainer):
		$Image/VBoxContainer.queue_free()
#	for node in get_parent().get_children():
#		if node.has_method('break_chain') and node != self:
#			node.break_chain()
#	queue_free()
