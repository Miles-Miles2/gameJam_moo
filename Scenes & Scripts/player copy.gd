extends CharacterBody2D


const SPEED = 90.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var iframes_timer: Timer = $iframes_timer
@onready var jumpSFX = $jumpSFX
@onready var hurtSFX = $hurtSFX

var addVelocityDebounce: int = 0
var iframes = false

@export var health = 4
@export var mult = 1
#@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#shader stuff

var previouslyInAir = true


func _physics_process(delta):
	# Add the gravity.
	addVelocityDebounce = max(0, addVelocityDebounce - 1)
	
	#if is_on_floor() and previouslyInAir:
	#	$CPUParticles2D.emitting = true
		#previouslyInAir = false
	
	if not is_on_floor():
		velocity.y += gravity * delta
		previouslyInAir = true
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpSFX.play()
		velocity.y += JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
		
	if is_on_floor():
		if direction == 0:
			pass
			animated_sprite.play("idle")	
			$AnimationPlayer.stop()
			$walkSFX.volume_db = -80.0
		else:
			pass
			animated_sprite.play("run")
			$AnimationPlayer.play("walk_sound")
			$walkSFX.volume_db = 0
	else:
		animated_sprite.play("jump")
		$AnimationPlayer.stop()
		$walkSFX.volume_db = -80.0
		
	
	
	if direction:
		if is_on_floor():
			velocity.x = direction * SPEED
		else:
			if abs(velocity.x + ((direction * SPEED)*0.01)) < SPEED:
				velocity.x += direction * SPEED * 0.1 #min((direction * SPEED)*0.01, direction*SPEED - velocity.x)
			elif abs(velocity.x	 + (direction * SPEED)*0.01) < abs(velocity.x):
				velocity.x += (direction * SPEED)*0.01
		
	else:
		if is_on_floor():
			velocity.x = 0
		else:
			velocity.x *= 0.95

	move_and_slide()

func invincibility():
	if iframes == true:
		animated_sprite.visible = false
		#print("on")
		await get_tree().create_timer(.25).timeout
		#print("off")
		animated_sprite.visible = true
		await get_tree().create_timer(.25).timeout
		invincibility()

func damage(num):
	if iframes == false:
		iframes = true
		hurtSFX.play()
		mult = num
		health -= 1*mult
		iframes_timer.start()
		invincibility()
		
func _on_iframes_timer_timeout() -> void:
	iframes = false
