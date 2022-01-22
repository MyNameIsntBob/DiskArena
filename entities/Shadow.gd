extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_frame = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if frame > max_frame:
		frame = max_frame
		
	$SecondaryShadow.frame = frame + 1
