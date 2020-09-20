extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
var playerVelocity = Vector2()
var playerDistance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every phys frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	playerVelocity.y += delta * playerGravity 
	
	# distance = velocity * time (right?)
	playerDistance = playerVelocity * delta
	move_and_collide(playerDistance)
