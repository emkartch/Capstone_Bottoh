extends Control

# Base created with the help of Thomas Yanuziello - https://youtu.be/noOSZjaiTmo?si=HZuF39mPLIxkaSoa

@onready var main = get_node("/root/Main")
@onready var _speaker = $VBoxContainer/Speaker
@onready var _dialogue = $VBoxContainer/Dialogue
@onready var _choice_container = $VBoxContainer/ChoiceContainer
@onready var continue_button = $Box/Continue
@onready var container = $VBoxContainer
@onready var background = $"../GreyOut"
@onready var option_1 = $"VBoxContainer/ChoiceContainer/Option 1"
@onready var option_2 = $"VBoxContainer/ChoiceContainer/Option 2"
@onready var option_3 = $"VBoxContainer/ChoiceContainer/Option 3"
@onready var inventory = get_node("/root/Main/Inventory")


signal continue_true

var previous_button_text = null

func _ready():
	
	option_1.pressed.connect(_on_option_pressed.bind(option_1))
	option_2.pressed.connect(_on_option_pressed.bind(option_2))
	option_3.pressed.connect(_on_option_pressed.bind(option_3))
	
	randomize()

func display_line(pause: bool,grey_out: bool, type: String, line, speaker : String = ""):
	_speaker.visible = (speaker != "")
	_speaker.text = speaker
	
	_choice_container.visible = (type == "question")
	
	if type == "narrator":
		
		_dialogue.text = "[color=#8f563b]" + line + "[/color]"
		
	elif type == "thought":
		
		_dialogue.text = "[i]" + line + "[/i]"
		
	elif type == "speech":
		
		_dialogue.text = line
		
	elif type == "question":
		
		continue_button.visible = false
		
		_dialogue.text = "[i]" + line[0] + "[/i]"
		
		line[1].shuffle()
		
		var iter = 1
		
		for option in line[1]:
			
			var button = _choice_container.get_node("Option " + str(iter))
			
			button.visible = true
			
			button.correct = option[0]
			
			button.type = option[1]
			
			button.text = option[2]
			
			button.response = option[3]
			
			iter += 1
	
	elif type == "followup":
		
		for option in line:
			
			if option[2] == previous_button_text:
				
				
				if option[0] == "narrator":
					
					_dialogue.text = "[color=#8f563b]" + option[1] + "[/color]"
					
				elif option[0] == "thought":
					
					_dialogue.text = "[i]" + option[1] + "[/i]"
					
				elif option[0] == "speech":
					
					_speaker.visible = (option[3] != "")
					_speaker.text = option[3]
					
					_dialogue.text = option[1]
	
	elif type == "check":
		
		var line_choice = null
		
		if Global.appearance_filled and Global.clothes_1_filled and Global.clothes_2_filled and Global.hats_filled and Global.colors_filled and Global.long_hairs_filled and Global.short_hairs_filled:
			
			line_choice = line[0]
			
		elif Global.appearance_filled or Global.clothes_1_filled or Global.clothes_2_filled or Global.hats_filled or Global.colors_filled or Global.long_hairs_filled or Global.short_hairs_filled:
			
			line_choice = line[1]
			
		else:
			
			line_choice = line[2]
		
		_speaker.visible = (line_choice[2] != "")
		_speaker.text = line_choice[2]
		
		if line_choice[0] == "narrator":
			
			_dialogue.text = "[color=#8f563b]" + line_choice[1] + "[/color]"
			
		elif line_choice[0] == "thought":
			
			_dialogue.text = "[i]" + line_choice[1] + "[/i]"
			
		elif line_choice[0] == "speech":
			
			_dialogue.text = line_choice[1]
			
		
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
	
	emit_signal("continue_true")

func _on_continue_pressed() -> void:
	
	Audio.play_audio('sfx',Audio.sfx_click)
	
	close()

func _on_option_pressed(node) -> void:
	
	if node.correct:
		
		_choice_container.visible = false
		
		if node.type == "narrator":
			
			_dialogue.text = "[color=#8f563b]" + node.response + "[/color]"
			
		elif node.type == "speech":
			
			_speaker.visible = true
			_speaker.text = "You"
			
			_dialogue.text = node.response
		
		previous_button_text = node.response
		continue_button.visible = true
	
	else:
		
		_dialogue.text = "[i]" + node.response + "[/i]"
		
		node.visible = false
		
