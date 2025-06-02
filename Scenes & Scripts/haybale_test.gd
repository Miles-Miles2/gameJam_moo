extends Node2D
#creates arrays of every attack in the game depending on type
@onready var hayarr = get_tree().get_nodes_in_group("hay")
@onready var spikearr = get_tree().get_nodes_in_group("spike")
@onready var tractorarr = get_tree().get_nodes_in_group("tractor")
@onready var ufoarr = get_tree().get_nodes_in_group("ufo")
@onready var pitchforkarr = get_tree().get_nodes_in_group("pitchfork")
@onready var slamarr = get_tree().get_nodes_in_group("slam")
@onready var game_time: Timer = $Timers/game_time
@onready var time_label: Label = $Labels/Label
@onready var health_label: Label = $Labels/Label2
@onready var node_2d: Node2D = $Pitchforks/Node2D
@onready var player: CharacterBody2D = $Player
@onready var p_1_2_music: AudioStreamPlayer2D = $P1_2_music
@onready var p_3_music: AudioStreamPlayer2D = $"P3 music"

var count = 2
var active = true
@export var phase = 1
@export var spiketime: int = 2.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_1_2_music.play()
	game_time.start()
	await get_tree().create_timer(3).timeout
	if game_time.time_left >=190:
		print("hi")
		spikeattack()
	execute()
	await get_tree().create_timer(7).timeout
	spikeattack()
	
func execute():
	if active == true:
		if phase == 2:
			count = 3
		if phase == 3:
			count = 4
		for i in count:
			var att = int(randf_range(0,4))
			match att:
				0:
					ufoattack()
					print("HAYTIME")
				1:
					tractorattack()
					print("TRACTOR")
				2:
					pitchforkattack()
					print("UFO")
				3:
					hayattack()
					print("PITCHFORK")
		await get_tree().create_timer(12).timeout
		execute()
	
func spikeattack():
	for i in spikearr:
		i.enable()
		await get_tree().create_timer(spiketime).timeout
	if spiketime != 2:
		spiketime -= .5
	spikeattack()
	
func hayindex():
	return int(randf_range(0,hayarr.size()-1))
	
func hayattack():
	var mult = 1
	if phase == 2:
		mult = 2
	if phase == 3:
		mult = 3
	for i in hayarr.size()/3*mult:
		var index = hayindex()
		hayarr[index].enable()
		await get_tree().create_timer(.5).timeout

func tractorattack():
	var index = int(randf_range(0,2))
	print(index)
	if game_time.time_left >= 90:
		tractorarr[index].enable()
	else:
		tractorarr[0].enable()
		tractorarr[1].enable()

func ufoattack():
	var index = int(randf_range(0,2))
	if game_time.time_left ==2:
		if ufoarr[index].active != true:
			ufoarr[index].enable()
		else:
			pass
	else:
		var index2 = int(randf_range(0,2))
		if index2 == 1:
			if ufoarr[index2].active != true:
				ufoarr[index2].enable()
			else:
				pass
			
			if ufoarr[0].active != true:
				await get_tree().create_timer(1).timeout
				ufoarr[0].enable()
			else:
				pass
				
		else:
			if ufoarr[index2].active != true:
				ufoarr[index2].enable()
			else: 
				pass
			if ufoarr[1].active != true:	
				await get_tree().create_timer(1).timeout
				ufoarr[1].enable()
	
func pitchforkattack():
	for i in phase:
		var index = int(randf_range(0,4))
		pitchforkarr[index].enable()
		await get_tree().create_timer(1).timeout
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_label.text = (str(int(game_time.time_left/60)) + ":" + str(int(game_time.time_left) % 60))
	health_label.text = (str(player.health))


func _on_p_1_time_timeout() -> void:
	phase += 1
	print("Now on phase " + str(phase))

func _on_p_2_time_timeout() -> void:
	p_1_2_music.stop()
	p_3_music.play()
	phase += 1
	print("Now on phase " + str(phase))

func _on_game_time_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes & Scripts/ending.tscn")
	active = false
	print("YOU DID IT!!!")


func _on_safe_timeout() -> void:
	pass # Replace with function body.
