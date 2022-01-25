extends Sprite

var max_frame = 4


func _process(delta):
	if frame > max_frame:
		frame = max_frame
		
	$SecondaryShadow.frame = frame + 1
