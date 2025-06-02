extends Node2D

@export var ending = false
@onready var musicSFX: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	musicSFX.play()
	$Cutscene.play("cutscene")
	if (ending == false) :
		await get_tree().create_timer(36.5).timeout
		$ColorRect/AnimationPlayer.play("close")
		await get_tree().create_timer(0.6).timeout
		get_tree().change_scene_to_file("res://Scenes & Scripts/haybale_test.tscn")
	else :
		pass
	


func _on_button_2_pressed() -> void:
	$ColorRect/AnimationPlayer.play("close")
	await get_tree().create_timer(0.6).timeout
	get_tree().quit()
func _on_button_pressed() -> void:
	$ColorRect/AnimationPlayer.play("close")
	await get_tree().create_timer(0.6).timeout
	get_tree().change_scene_to_file("res://Scenes & Scripts/haybale_test.tscn")
