extends Control

func _ready() -> void:
	$Label/AnimationPlayer.play("updown")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") :
		$ColorRect/AnimationPlayer.play("close")
		$AudioStreamPlayer.stop()
		await get_tree().create_timer(0.6).timeout
		get_tree().change_scene_to_file("res://Scenes & Scripts/init_scene.tscn")
