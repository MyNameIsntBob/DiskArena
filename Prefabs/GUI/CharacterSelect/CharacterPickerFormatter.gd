extends HBoxContainer

export (NodePath) var name_label_path
var name_label
export (NodePath) var join_label_path
var join_label
export (NodePath) var select_label_path
var select_label
export (NodePath) var character_path
var character
export (NodePath) var box_path
var box
export (NodePath) var level_path
var level_node
export (NodePath) var top_padding_path
var top_padding

var player
var id
var level
var level_selected


func _ready():
	top_padding = get_node(top_padding_path)
	join_label = get_node(join_label_path)
	name_label = get_node(name_label_path)
	select_label = get_node(select_label_path)
	character = get_node(character_path)
	box = get_node(box_path)
	level_node = get_node(level_path)


func _process(delta):
	join_label.visible = !player
	
	select_label.visible = player and !level_selected
	
	if box:
		if !player:
			box.texture = Icons.get_box(4)
		elif !player['selected']:
			box.texture = Icons.get_box(1)
		elif !level_selected:
			box.texture = Icons.get_box(2)
		else:
			box.texture = Icons.get_box(3)
	
	if name_label and character:
		if player:
			if get_parent().taken():
				character.texture = Icons.get_gui_taken_character(player['character_id'])
			else:
				character.texture = Icons.get_gui_character(player['character_id'])
			character.show()
			name_label.text = Icons.character_from_id[int(player["character_id"])]
			name_label.show()
		
			if player['selected']:
				level_node.texture = Icons.get_map_icon(level)
		
		else:
			if get_parent().parent.num_of_players() + get_parent().parent.num_of_bots > id: 
				character.texture = Icons.gui['characters']['Ai']
				character.show()
				join_label.hide()
				box.texture = Icons.get_box(4)
			else:
				name_label.hide()
				character.hide()
	
	level_node.visible = player && player['selected']


