extends Control

export var player_id : int
var character_id

onready var HEART = preload("res://ui/Heart.tscn")

var hp_icons : Array


func setup():
	if !valid():
		print("Invalid player_id: ", player_id)
		return
	
	print("Valid player_id: ", player_id)
	
	
	var max_hp = ScoreKeeper.get_max_hp(player_id)
	for i in range(max_hp):
		var heart = HEART.instance()
		hp_icons.append(heart)
		add_child(heart)


func _process(delta):
	change_hp_icons()


#This works for now, but we might want to change the icons to 
#generate based off of hp and max hp in the future just for simplicity
func change_hp_icons():
	if !valid():
		return
	
	var hp = ScoreKeeper.get_hp(player_id)
	for i in range(len(hp_icons)):
		if hp < i + 1:
			hp_icons[i].get_child(0).set_frame(4)
		else:
			hp_icons[i].get_child(0).set_frame(character_id - 1)


func valid():
	character_id = ScoreKeeper.get_character_id(player_id)
	return character_id != null
