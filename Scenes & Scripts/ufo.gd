extends Node2D

@onready var pos = position
@onready var bounce_time: Timer = $bounce
@onready var hitbox: CollisionShape2D = $laser_hitbox/CollisionShape2D
@onready var laserbox: CollisionShape2D = $ufo_hitbox/CollisionShape2D
@onready var timer: Timer = $Timer
@onready var ray: Sprite2D = $Sprite2D
@onready var position_reset_timer: Timer = $position_reset
@onready var zap_attack: AnimationPlayer = $AnimationPlayer

@export var active = false
@export var speed = 50
@export var dir = 1

var should_bounce = false

func _ready() -> void:
	enable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		position.x += speed*delta*dir
	print(should_bounce)
	
func enable():
	print(pos)
	bounce_time.start()
	active = true
	await get_tree().create_timer(1).timeout
	zap_attack.play("zap")
	
func disable():
	zap_attack.stop()
	hitbox.disabled = true
	ray.visible = false
	should_bounce = false
	speed = 300
	position_reset_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(1)

func _on_bounce_timeout() -> void:
	should_bounce = true

func _on_timer_timeout() -> void:
	disable()

func _on_position_reset_timeout() -> void:
	active = false
	position = pos


func _on_ufo_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ground") && should_bounce == true:
		dir *= -1
