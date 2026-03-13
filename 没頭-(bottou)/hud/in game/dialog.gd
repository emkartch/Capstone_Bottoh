extends Control

# Created with the help of Thomas Yanuziello - https://youtu.be/noOSZjaiTmo?si=HZuF39mPLIxkaSoa

@onready var main = get_node("/root/Main")
@onready var _speaker = $VBoxContainer/Speaker
@onready var _dialogue = $VBoxContainer/Dialogue
@onready var container = $VBoxContainer
@onready var background = $"../GreyOut"

signal continue_true

func display_line(pause: bool,grey_out: bool, type: String, line: String, speaker : String = ""):
	_speaker.visible = (speaker != "")
	_speaker.text = speaker
	
	if type == "narrator":
		
		_dialogue.text = "[color=#8f563b]" + line + "[/color]"
		
	elif type == "thought":
		
		_dialogue.text = "[i]" + line + "[/i]"
		
	elif type == "speech":
		
		_dialogue.text = line
	
	if speaker != "":
		
		container.anchor_top = 0.11
	
	else:
	
		container.anchor_top = 0.09
	
	if pause:
		Global.main_pause = true
		
	if grey_out:
		background.color.a = 111
	else:
		background.color.a = 0
	
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
	
	emit_signal("continue_true")

func _on_continue_pressed() -> void:
	close()
