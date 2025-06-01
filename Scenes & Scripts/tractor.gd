extends Node2D

@onready var pos = position
@onready var killbox: CollisionShape2D = $AnimatedSprite2D/AnimatableBody2D/killbox/CollisionShape2D
@onready var top_hitbox: CollisionShape2D = $AnimatedSprite2D/AnimatableBody2D/CollisionShape2D
@onready var drive_ani: AnimatedSprite2D = $AnimatedSprite2D
@onready var bounce_time: Timer = $bounce_timer
@onready var total_timer: Timer = $total_timer
@onready var reset_timer: Timer = $reset_timer

@export var should_bounce: bool = false
@export var active: bool = false
@export var speed: int = 50
@export var dir: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable()

func enable():
	total_timer.start()
	bounce_time.start()
	drive_ani.play("drive")
	active = true

func disable():
	killbox.disabled = true
	top_hitbox.disabled = true
	speed *= 4
	await get_tree().create_timer(2).timeout
	active = false
	position = pos
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		position.x -= speed*delta*dir

func _on_killbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(1)
	if body.is_in_group("ground") && should_bounce:
		drive_ani.flip_h = !drive_ani.flip_h
		dir *= -1
		print(dir)

func _on_timer_timeout() -> void:
	should_bounce = true

func _on_total_timer_timeout() -> void:
	disable()
