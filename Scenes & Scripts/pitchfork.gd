extends Node2D

var launch = false


func _process(delta: float) -> void:
	if launch == false : look_at($"../Player".position)
	await get_tree().create_timer(3).timeout
	launch = true
	print("TIME")
	
	var rotation_radians = deg_to_rad(rotation_degrees)
	# Calculate direction vector
	var direction = Vector2(cos(rotation_radians), sin(rotation_radians))
	
	# Normalize the vector (optional, but ensures length = 1)
	direction = direction.normalized()
	position += direction
