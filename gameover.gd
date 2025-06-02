extends Control

func _ready() -> void:
	$Label/AnimationPlayer.play("fade_in")
	await get_tree().create_timer(0.1).timeout
	$Label2/AnimationPlayer.play("fade_in")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") :
		get_tree().change_scene_to_file("res://Scenes & Scripts/haybale_test.tscn")
