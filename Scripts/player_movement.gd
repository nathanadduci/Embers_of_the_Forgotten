extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
export var playerSpeed = 400
var playerVelocity = Vector2()
var playerDistance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every phys frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# obtain new y velocity
	playerVelocity.y += delta * playerGravity 
	
	#obtain new x velocity
	_inputSequence()
	
	# distance = velocity * time (right?)
	# playerDistance = playerVelocity * delta
	move_and_slide(playerVelocity, Vector2(0,-1))

func _inputSequence():
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		playerVelocity.x = playerSpeed
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		playerVelocity.x = -playerSpeed
	else:
		if playerVelocity.x > 1:
			playerVelocity.x = playerVelocity.x / 5
		else:
			playerVelocity.x = 0
