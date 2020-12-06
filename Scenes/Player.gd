extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var acceleration := 100
var velocity := Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	var movement = Vector2(0, 0)
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
		
	velocity += movement.normalized() * acceleration
	move_and_slide(movement.normalized() * acceleration)
	
