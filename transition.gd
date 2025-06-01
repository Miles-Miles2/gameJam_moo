extends ColorRect

func _ready() -> void:
	$AnimationPlayer.play("open")
func close() -> void:
	$AnimationPlayer.play("close")
