extends Node

@onready var music = get_node("/root/Main/Music")
@onready var sfx = get_node("/root/Main/SFX")

@onready var music_airport = preload("res://audio/Music/Airport Music.wav")
@onready var music_generic_indoor = preload("res://audio/Music/Generic Indoor Music.wav")
@onready var music_outdoor = preload("res://audio/Music/Outdoor Music.wav")

@onready var sfx_airplane = preload("res://audio/SFX/Airplane SFX (Speed).wav")
@onready var sfx_bag_close = preload("res://audio/SFX/Close Bag SFX.wav")
@onready var sfx_CS_ding = preload("res://audio/SFX/Convenience Store Ding SFX.wav")
@onready var sfx_correct = preload("res://audio/SFX/Correct SFX (Cut).wav")
@onready var sfx_door_slide = preload("res://audio/SFX/Door Slide SFX.wav")
@onready var sfx_incorrect = preload("res://audio/SFX/Incorrect SFX (Cut).wav")
@onready var sfx_bag_open = preload("res://audio/SFX/Open Bag SFX.wav")
@onready var sfx_page_turn = preload("res://audio/SFX/Turning Page SFX (Cut).wav")
@onready var sfx_paper_rustle = preload("res://audio/SFX/Paper Rustling SFX (Cut).wav")
@onready var sfx_click = preload("res://audio/SFX/Click SFX.wav")
@onready var sfx_stamp = preload("res://audio/SFX/Stamp SFX (Cut).wav")

func play_audio(type,soundclip):
	
	if type == "music":
		
		music.stream = soundclip
		await fade_in()
	
	elif type == "sfx":
		
		sfx.stream = soundclip
		sfx.play()

func stop_audio(type):
	
	if type == "music":
		
		await fade_out()
	
	elif type == "sfx":
		
		sfx.stop()

func fade_in(duration: float = 1.0):
	# Create a tween to animate volume
	music.volume_db = -80.0
	music.play()
	var tween = create_tween()
	# Transition from current volume to 0dB 
	tween.tween_property(music, "volume_db", 0.0, duration)
	await tween.finished


func fade_out(duration: float = 1.0):
	# Create a tween to animate volume
	var tween = create_tween()
	# Transition from current volume to -80dB (silent)
	tween.tween_property(music, "volume_db", -80.0, duration)
	await tween.finished
	# Callback to stop the player after the tween finishes
	#music.stop()
	#tween.tween_callback(music.stop)
	# Optional: reset volume to 0 for next play
	#tween.tween_callback(func(): music.volume_db = 0) 
