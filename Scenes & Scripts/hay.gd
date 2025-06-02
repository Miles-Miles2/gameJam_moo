extends Node2D

@onready var bale: Sprite2D = $Sprite2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var pos = position

@export var speed = 100
@export var active  = false

func _ready():
	#enable()
	pass

func enable():
	print(pos)
	active = true
	bale.visible = active
	hitbox.disabled = !active

func disable():
	active = false
	bale.visible = active
	hitbox.disabled = !active
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		position.y += delta*speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(1)
		if body.iframes == false:
			disable()
