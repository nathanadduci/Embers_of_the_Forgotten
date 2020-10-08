extends KinematicBody2D

var velocity = Vector2()
var movement = 500
var damage = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = movement # Replace with function body.

func _physics_process(delta):
	#move_and_slide(velocity)
	velocity.x = movement*delta
	var collision_info = move_and_collide(velocity)
	if(collision_info != null and collision_info.collider.get_collision_layer() == 4):
		#print(collision_info.collider.get_collision_layer())
		var damageDirection = (collision_info.collider.position.x - position.x) / abs(collision_info.collider.position.x - position.x)
		collision_info.collider.damage(damage, damageDirection)
		queue_free()
	if position.x < -1000 or position.x > 10000:
		queue_free()

