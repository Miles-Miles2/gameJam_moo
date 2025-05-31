extends Node2D

@onready var spike: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	enable()

func enable():
	spike.play("warning")
	await get_tree().create_timer(2).timeout
	spike.play("attack")
	hitbox.disabled = false
	await get_tree().create_timer(2).timeout
	hitbox.disabled = true
	spike.play("retreat")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("OWIE")
	if body.is_in_group("player"):
		body.damage(1)
