extends KinematicBody2D



export var slimeGravity = 9.81 * 10
export var slimeSpeed = 150
export var damageSpeed = 50
export var terminalVelocity = 1200
export var floatDenominator = 1.3
export var slimeJumpImpulse = 400
var slimeVelocity = Vector2()
var slimeDistance
var damageTimer = -OS.get_ticks_msec()
var damageDirection = 0
var attackTimer = -OS.get_ticks_msec()
var maxHealth = 2*50
var currentHealth
var attackSwitch = false
var attackDamage = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	slimeVelocity.y = slimeGravity
	currentHealth = maxHealth


func _physics_process(delta):
	
	# obtain new y velocity and check crouch
	if is_on_floor():
		if get_parent().get_node("Player").position.y - position.y > 5:
			slimeVelocity.y = slimeJumpImpulse
		else:
			slimeVelocity.y = slimeGravity
	else:
		if slimeVelocity.y < terminalVelocity:
			slimeVelocity.y += delta * slimeGravity 
		else: 
			slimeVelocity.y = terminalVelocity
	#print(slimeVelocity.y)
	
	#obtain new x velocity
	if(currentHealth > 0 and (damageTimer < 0 or OS.get_ticks_msec()-damageTimer>=250)):
		damageTimer = -OS.get_ticks_msec()
		if abs($"../Player".position.x-position.x) < 30:
			slimeVelocity.x = 0
			$SlimeSprite.play("attack")
			if(!attackSwitch):
				$"../Player".damage(attackDamage)
				attackSwitch = true
		else:
			attackSwitch = false
			if abs(get_parent().get_node("Player").position.x - position.x) > 800:
				slimeVelocity.x = 0
				$SlimeSprite.play("idle")
			elif get_parent().get_node("Player").position.x > position.x:
				slimeVelocity.x = slimeSpeed
				$SlimeSprite.play("move")
			else:
				slimeVelocity.x = -slimeSpeed
				$SlimeSprite.play("move")
	elif(currentHealth < 0 and OS.get_ticks_msec()-damageTimer >= 650):
		queue_free()
		print(OS.get_ticks_msec()-damageTimer)
		#slimeVelocity.x = damageSpeed * damageDirection
		#$SlimeSprite.play("death")
		
		
			
	# distance = velocity * time (right?)
	# playerDistance = slimeVelocity * delta
	move_and_slide(slimeVelocity, Vector2(0,-1))
	#var collision_info = move_and_collide(slimeVelocity)
	#if(damageTimer < 0 and collision_info != null and collision_info.collider.get_collision_layer() == 16):
	#	damageTimer = OS.get_ticks_msec()
	#	damageDirection = -(collision_info.collider.position.x - position.x) / abs(collision_info.collider.position.x - position.x)

func damage(dmg, dir):
	currentHealth -= dmg
	if damageTimer < 0 :
		$HealthBar.update_healthbar(currentHealth)
		damageTimer = OS.get_ticks_msec()
		damageDirection = dir#-(collision_info.collider.position.x - position.x) / abs(collision_info.collider.position.x - position.x)
		slimeVelocity.x = damageSpeed * damageDirection
		if(currentHealth > 0):
			$SlimeSprite.play("damaged")
		else:
			$SlimeSprite.play("death")
		

