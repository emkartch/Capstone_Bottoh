extends Control

# Created with the help of Thomas Yanuziello - https://youtu.be/noOSZjaiTmo?si=HZuF39mPLIxkaSoa

@onready var main = get_node("/root/Main")
@onready var _speaker = $VBoxContainer/Speaker
@onready var _dialogue = $VBoxContainer/Dialogue
#@onready var _continue = $Box/Continue
@onready var background = $"../GreyOut"

func display_line(pause: bool, line: String, speaker : String = ""):
	_speaker.visible = (speaker != "")
	_speaker.text = speaker
	_dialogue.text = line
	
	if pause:
		Global.main_pause = true
	
	open()

func open():
	
	if Global.main_pause:
		background.visible = true
		main.get_tree().paused = true
	
	visible = true

func close():
	
	if Global.main_pause:
		background.visible = false
		main.get_tree().paused = false
		Global.main_pause = false
	
	visible = false
	
	if Global.game_end:
		main.get_tree().quit()

func _on_continue_pressed() -> void:
	close()
