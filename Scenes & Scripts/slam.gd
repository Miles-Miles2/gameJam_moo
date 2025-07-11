extends CharacterBody2D

@onready var killbox: CollisionShape2D = $Area2D/killbox

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var use_gravity = true
var multiply = 1

const JUMP_TO = -100

var vel = 0;

var fall = false

func _physics_process(delta):
	if use_gravity == true :
		velocity.y += delta * GRAVITY * multiply
	elif use_gravity == false :
		velocity.y = 0

	var motion = velocity * delta
	move_and_collide(motion)
	
func _on_jump_timer_timeout() -> void:
	use_gravity = false
	$JumpTimer.start()
	$jumpSFX.play()
	await $JumpTimer.timeout
	position = Vector2($"../Player".position.x, JUMP_TO)
	$SlamTimer.start()
	await $SlamTimer.timeout
	multiply = 1.5
	velocity = Vector2.ZERO
	use_gravity = true;
	$StartTimer.start
func _process(delta: float) -> void:
	if $SlamTimer.time_left > 0 and $"../Player" :
		position.x = $"../Player".position.x
	elif $JumpTimer.time_left > 0 :
		position = position.lerp(Vector2($"../Player".position.x, JUMP_TO), delta * 5)
	else :
		pass
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and fall == true:
		body.damage(1)
