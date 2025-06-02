extends Node2D

@onready var killbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var pos = position
@onready var reset_timer: Timer = $reset_timer
@onready var player: CharacterBody2D = $"../../Player"

@export var speed = 200
@export var active = false
var launch = false

func enable():
	active = true
	reset_timer.start()

func _physics_process(delta: float) -> void:
	#print(str(launch) + "LaunchPP")
	#print(str(active)+ "ActivePP")
	if active:
		if launch == false : look_at(player.position)
		await get_tree().create_timer(3).timeout
		launch = true
		#print("TIME")
		
		var rotation_radians = deg_to_rad(rotation_degrees)
		# Calculate direction vector
		var direction = Vector2(cos(rotation_radians), sin(rotation_radians))
		
		# Normalize the vector (optional, but ensures length = 1)
		direction = direction.normalized()
		position += direction*delta*speed
	if !active:
		position = pos
		launch = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(1)



	
func _on_reset_timer_timeout() -> void:
	active = false
	position = pos
	launch = false
	print(str(launch) + "Launch")
	print(str(active)+ "Active")
