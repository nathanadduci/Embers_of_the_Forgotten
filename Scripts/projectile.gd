extends KinematicBody2D

var velocity = Vector2()
var movement = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 3*movement # Replace with function body.

func _physics_process(delta):
	move_and_slide(velocity)
	print_debug(get_tree().get_root().get_pos())
